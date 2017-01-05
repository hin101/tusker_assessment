class CreateBoxContents < ActiveRecord::Migration[5.0]
  def change
    create_table :box_contents do |t|
      t.belongs_to :box
      t.belongs_to :content
      t.timestamps
    end
  end
end
