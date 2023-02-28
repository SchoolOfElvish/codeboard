# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[7.0]
  def up
    create_table :lessons, bulk: true do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :lessons, bulk: true
  end
end
