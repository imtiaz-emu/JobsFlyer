class Job < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :company
  has_many :skills, :through => :job_skills
  has_many :job_skills, :dependent => :destroy

  attr_accessor :job_skills_attributes


  validates_presence_of :title, :vacancies, :job_type, :deadline, :apply_instructions
  validates_numericality_of :vacancies

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
end
