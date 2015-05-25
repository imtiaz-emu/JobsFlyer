class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # callbacks
  after_create :create_default_profile
  # associations
  has_one :profile

  # validations

  # scopes

  # Constants

  # Instance methods

  private

  def create_default_profile
    @profile = self.profile.build(:first_name => self.email.split('@')[0])
    @profile.save(:validate => false)
  end

end
