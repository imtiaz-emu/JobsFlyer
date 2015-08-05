class Post < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

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


  private
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
