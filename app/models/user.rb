class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # callbacks

  # associations
  has_one :profile
  # validations

  # scopes

  # Instance methods

  # Constants

end
