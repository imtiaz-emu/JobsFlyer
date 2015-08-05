class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer     :user_id
      t.integer     :company_id
      t.text        :title
      t.text        :description
      t.string      :feature_image
      t.integer     :post_type
      t.text        :slug

      t.timestamps null: false
    end
  end
end
