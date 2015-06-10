class AddColumnJobFeatureTypeToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :featured_job, :boolean
  end
end
