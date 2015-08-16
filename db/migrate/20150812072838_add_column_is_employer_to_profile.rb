class AddColumnIsEmployerToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :is_employer, :boolean
  end
end
