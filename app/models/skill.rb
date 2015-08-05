class Skill < ActiveRecord::Base
  has_many :jobs, :through => :job_skills
  has_many :job_skills, :dependent => :destroy
  has_and_belongs_to_many :posts
end
