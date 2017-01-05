class AddUserIdToBox < ActiveRecord::Migration[5.0]
  def change
    add_reference :boxes, :user, foreign_key: true
  end
end
