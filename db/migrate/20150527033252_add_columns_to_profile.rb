class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :city, :string
    add_column :profiles, :state, :string
    add_column :profiles, :country, :string
    add_column :profiles, :status, :string
    add_column :profiles, :description, :text
  end
end
