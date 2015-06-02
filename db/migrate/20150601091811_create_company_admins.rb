class CreateCompanyAdmins < ActiveRecord::Migration
  def change
    create_table :company_admins do |t|
      t.integer       :company_id
      t.integer       :user_id
      t.string        :user_role

      t.timestamps null: false
    end
  end
end
