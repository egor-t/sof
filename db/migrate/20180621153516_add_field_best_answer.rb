# frozen_string_literal: true

class AddFieldBestAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :best_answer, :boolean, default: false
  end
end
