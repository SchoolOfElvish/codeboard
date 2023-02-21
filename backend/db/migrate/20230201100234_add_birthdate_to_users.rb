# frozen_string_literal: true

class AddBirthdateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthdate, :date, null: true
  end
end
