class RemoveRelationships < ActiveRecord::Migration
  def up
    drop_table :relationships
  end
  
  def down
    create_table "relationships", force: true do |t|
      t.integer  "follower_id"
      t.integer  "followed_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  
    add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
    add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"
  end
end
