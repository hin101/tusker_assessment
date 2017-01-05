class RemoveUserFromBox < ActiveRecord::Migration[5.0]
  def change
  	remove_column :boxes, :user_id
  end
end
