# frozen_string_literal: true

class AddAboutInfoToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :about_info, :text
  end

  def down
    remove_column :users, :about_info
  end
end
