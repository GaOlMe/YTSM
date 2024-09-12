class CreateChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :channels do |t|
      t.string :channel_name
      t.string :channel_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
