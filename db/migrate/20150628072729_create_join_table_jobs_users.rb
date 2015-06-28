class CreateJoinTableJobsUsers < ActiveRecord::Migration
  def change
    create_join_table :jobs, :users do |t|
      # t.index [:job_id, :user_id]
      # t.index [:user_id, :job_id]
    end
  end
end
