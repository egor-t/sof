class CreateSubsriptionToQuestion < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true
      t.timestamps
    end

    add_index :subscriptions, [:user_id, :question_id], unique: true
  end
end
