class Company < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :user
  has_many :company_locations, :dependent => :destroy


  accepts_nested_attributes_for :company_locations, :reject_if => proc {|attributes| attributes[:branch_type].blank? || attributes[:phone].blank? || attributes[:country].blank? || attributes[:state].blank?}, :allow_destroy => true

  extend FriendlyId
  friendly_id :web_address, use: :slugged

  validates_presence_of :name, :organization_category_id, :logo, :bg_image, :web_address

  mount_uploader :logo, CompanyUploader
  mount_uploader :bg_image, CompanyUploader

  EMPLOYEE_RANGE = ['1-5', '6-15', '16-30', '30-50', '50+']

  private
  def should_generate_new_friendly_id?
    slug.blank? || web_address_changed?
  end
end
