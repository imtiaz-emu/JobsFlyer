class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # callbacks
  after_create :create_default_profile
  # associations
  has_one :profile, :dependent => :destroy
  has_many :companies, :through => :company_admins
  has_many :company_admins, :dependent => :destroy

  has_many :followed_companies, :through => :followers, :class_name => 'Company'
  has_many :followers, :dependent => :destroy
  has_many :jobs, :through => :jobs_users
  has_many :jobs_users
  has_many :saved_resumes

  # validations

  # scopes

  # Constants

  # Instance methods

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def is_admin?
    self.email == 'admin@jobsflyer.com'
  end

  private

  def create_default_profile
    @profile = Profile.new(:user_id => self.id, :first_name => self.email.split('@')[0])
    @profile.save(:validate => false)
  end

end
