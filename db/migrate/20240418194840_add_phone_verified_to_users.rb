class AddPhoneVerifiedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_verified, :boolean, default: false
  end
end
