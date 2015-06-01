class CreateCompanyLocations < ActiveRecord::Migration
  def change
    create_table :company_locations do |t|
      t.integer     :company_id
      t.string      :branch_type
      t.string      :country
      t.string      :city
      t.string      :state
      t.string      :phone
      t.text        :description

      t.timestamps null: false
    end
  end
end
