class Job < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :company

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
end
