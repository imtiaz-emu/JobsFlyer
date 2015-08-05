class AddColumnCanPostToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :can_post, :boolean, default: false
  end
end
