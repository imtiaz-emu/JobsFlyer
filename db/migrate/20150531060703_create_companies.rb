class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer       :user_id
      t.integer       :organization_category_id
      t.string        :name
      t.string        :logo
      t.text          :description
      t.string        :bg_image
      t.string        :employee_range
      t.string        :website
      t.string        :web_address

      t.timestamps null: false
    end
  end
end
