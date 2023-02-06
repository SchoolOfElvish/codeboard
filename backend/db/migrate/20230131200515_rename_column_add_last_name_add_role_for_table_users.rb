# frozen_string_literal: true

class RenameColumnAddLastNameAddRoleForTableUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.rename :name, :first_name
      t.string :last_name,           null: false, default: ''
      t.integer :role,               default: 0
    end
  end
end