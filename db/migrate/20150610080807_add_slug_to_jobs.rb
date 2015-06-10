class AddSlugToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :slug, :text
    add_index :jobs, :slug, unique: true
  end
end
