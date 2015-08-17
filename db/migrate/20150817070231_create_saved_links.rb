class CreateSavedLinks < ActiveRecord::Migration
  def change
    create_table :saved_links do |t|
      t.integer   :user_id
      t.integer   :saveable_id
      t.string    :saveable_type

      t.timestamps null: false
    end
  end
end
