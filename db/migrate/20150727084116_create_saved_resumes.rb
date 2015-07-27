class CreateSavedResumes < ActiveRecord::Migration
  def change
    create_table :saved_resumes do |t|
      t.string    :job_seeker_email
      t.integer   :user_id

      t.timestamps null: false
    end
  end
end
