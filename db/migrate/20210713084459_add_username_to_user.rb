class AddUsernameToUser < ActiveRecord::Migration[6.1]
  def change
  	add_column :users, :name, :string, limit: 20
  end
end
