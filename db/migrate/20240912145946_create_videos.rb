class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :channel, null: false, foreign_key: true
      t.string :video_id
      t.string :embed_link
      t.string :thumbnail_url
      t.string :upload_date
      t.string :description
      t.integer :views
      t.string :duration

      t.timestamps
    end
  end
end
