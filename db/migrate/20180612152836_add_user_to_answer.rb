# frozen_string_literal: true

class AddUserToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :user_id, :integer, index: true
  end
end
