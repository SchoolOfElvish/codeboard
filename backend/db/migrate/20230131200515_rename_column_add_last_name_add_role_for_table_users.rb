# frozen_string_literal: true

class RenameColumnAddLastNameAddRoleForTableUsers < ActiveRecord::Migration[7.0]
  def up
    create_enum :users_role, %w[STUDENT TEACHER]
    change_table :users, bulk: true do |t|
      t.rename :name, :first_name
      t.string :last_name, null: false, default: ''
      t.enum :role, enum_type: :users_role, null: false
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.rename :first_name, :name
      t.remove :last_name, :role
    end
    execute 'DROP TYPE users_role;'
  end
end
