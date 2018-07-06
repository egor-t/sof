class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :commentable_type
      t.integer :commentable_id
      t.belongs_to :user, index: true
      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
  end
end
