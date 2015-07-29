class Company < ActiveRecord::Base
  belongs_to :organization_category
  has_many :users, :through => :company_admins
  has_many :company_admins, :dependent => :destroy
  has_many :company_locations, :dependent => :destroy
  has_many :jobs, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy

  has_many :followed_users, :through => :followers, :class_name => 'User'
  # has_many :users, :through => :followers
  has_many :followers, :dependent => :destroy

  after_save :save_full_location


  accepts_nested_attributes_for :company_locations, :reject_if => proc {|attributes| attributes[:branch_type].blank? || attributes[:phone].blank? || attributes[:country].blank? || attributes[:state].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :company_admins, :allow_destroy => true
  accepts_nested_attributes_for :followers, :allow_destroy => true

  extend FriendlyId
  friendly_id :web_address, use: :slugged

  validates_presence_of :name, :organization_category_id, :logo, :bg_image, :web_address

  mount_uploader :logo, CompanyUploader
  mount_uploader :bg_image, CompanyUploader

  include PgSearch
  pg_search_scope :quick_search,
                  against: [:name]

  EMPLOYEE_RANGE = ['1-5', '6-15', '16-30', '30-50', '50+']
  ADMIN_ROLE = ['admin','editor']

  def check_for_atleast_one_admin(company_admins)
    admins = 0
    company_admins.each do |ca|
      if ca['_destroy'] == 'false' && ca['user_role'] == 'admin'
        admins +=1
      end
    end
    if admins == 0
      errors.add(:base, "You must select at least on Admin for your company.")
      return false
    else
      return true
    end
  end

  def save_full_location
    self.company_locations.each do |location|
      location.full_location = location.city + ', '+ location.state + ', ' + Carmen::Country.coded(location.country).to_s
      location.save(:validate => false)
    end
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || web_address_changed?
  end
end
