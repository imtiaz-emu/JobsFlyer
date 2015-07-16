class Job < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :company
  has_many :skills, :through => :job_skills
  has_many :job_skills, :dependent => :destroy
  has_many :users, :through => :jobs_users
  has_many :jobs_users

  attr_accessor :job_skills_attributes

  scope :active_jobs, -> { where('deadline > ?', Date.today) }
  scope :expired_jobs, -> { where('deadline < ?', Date.today) }
  scope :normal_jobs, -> { where('featured_job = ?', false) }
  scope :featured_jobs, -> { where('featured_job = ?', true) }

  validates_presence_of :title, :vacancies, :job_type, :deadline, :apply_instructions
  validates_numericality_of :vacancies
  validate :check_job_deadline

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PgSearch
  pg_search_scope :quick_search,
                  against: [:title, :additional_requirement],
                  associated_against: {
                      skills: [:name],
                      company: [:name]
                  }

  after_create :manage_subscription

  JOB_TYPES = [
      'Full-time' => 1,
      'Part-time' => 2,
      'Contractual' => 3,
      'Intern'    => 4
  ]

  JOB_PAYMENT_TYPE = [
      'Fixed' => 1,
      'Hourly' => 2
  ]

  def update_job_skills_attributes(ids)
    skill_ids = ids.split(",")

    self.job_skills.each do |skill|
      skill.destroy if !skill_ids.include?(skill.skill_id)
    end

    skill_ids.each do |id|
      self.job_skills.create(:skill_id => id.to_i) unless (self.job_skills.select(:skill_id).include?(id.to_i))
    end
  end

  def manage_subscription
    self.company.subscriptions.active_subscriptions.each do |subscription|
      if subscription.feature_job > 0 && self.featured_job
        subscription.feature_job -= 1
        subscription.save(:validate => false)
        break
      elsif subscription.normal_job > 0 && !self.featured_job
        subscription.normal_job -= 1
        subscription.save(:validate => false)
        break
      end
    end
  end

  def check_job_deadline
    if self.new_record?
      if self.deadline > Date.today + 40.days
        errors[:base] << "You're trying to post the job deadline out of the range."
      end
    else
      if self.deadline > self.created_at + 40.days
        errors[:base] << "You're trying to post the job deadline out of the range."
      end
    end
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
