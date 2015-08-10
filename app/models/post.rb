class Post < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :likes, as: :likable, :dependent => :destroy
  has_and_belongs_to_many :skills
  accepts_nested_attributes_for :skills

  validates_presence_of :description, :title, :post_type

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :feature_image, CompanyUploader

  POST_TYPE = {
      'Tutorial' => 1,
      'Discussion' => 2,
      'Promotion' => 3,
      'News' => 4
  }

  def update_post_skills_attributes(ids)
    skill_ids = ids.split(",")

    self.skills.each do |skill|
      skill.destroy if !skill_ids.include?(skill.id.to_s)
    end

    skill_ids.each do |id|
      self.skills << Skill.find(id.to_i) if !self.skills.include?(Skill.find(id.to_i))
    end
  end


  private
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
