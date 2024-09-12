class AddGroupRefToChannel < ActiveRecord::Migration[7.1]
  def change
    add_reference :channels, :group, null: false, foreign_key: true
  end
end
