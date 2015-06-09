class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text        :title
      t.string      :job_type
      t.text        :salary_range
      t.boolean     :is_negotiable
      t.string      :payment_type
      t.text        :apply_instructions
      t.date        :deadline
      t.text        :additional_requirement
      t.integer     :company_id
      t.integer     :organization_category_id
      t.integer     :vacancies, :default => 1
      t.text        :experience_range
      t.text        :age_range
      t.text        :job_location
      t.boolean     :anywhere_in
      t.string      :anywhere_place
      t.string      :status
      t.string      :payment_currency

      t.timestamps null: false
    end
  end
end
