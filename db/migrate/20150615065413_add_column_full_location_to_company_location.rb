class AddColumnFullLocationToCompanyLocation < ActiveRecord::Migration
  def change
    add_column :company_locations, :full_location, :string
  end
end
