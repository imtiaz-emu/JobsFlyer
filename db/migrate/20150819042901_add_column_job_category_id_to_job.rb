class AddColumnJobCategoryIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :job_category_id, :integer
  end
end
