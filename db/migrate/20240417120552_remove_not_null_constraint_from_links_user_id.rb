class RemoveNotNullConstraintFromLinksUserId < ActiveRecord::Migration[7.1]
  def change
    change_column_null :links, :user_id, true
  end
end
