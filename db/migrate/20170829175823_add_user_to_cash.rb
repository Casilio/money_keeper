class AddUserToCash < ActiveRecord::Migration[5.1]
  def change
    add_reference :cashes, :user, foreign_key: true
  end
end
