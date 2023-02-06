class AddTokenIssuedAtToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token_issued_at, :datetime
  end
end
