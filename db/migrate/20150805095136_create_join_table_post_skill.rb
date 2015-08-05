class CreateJoinTablePostSkill < ActiveRecord::Migration
  def change
    create_join_table :posts, :skills do |t|
      # t.index [:post_id, :skill_id]
      # t.index [:skill_id, :post_id]
    end
  end
end
