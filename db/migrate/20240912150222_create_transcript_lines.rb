class CreateTranscriptLines < ActiveRecord::Migration[7.1]
  def change
    create_table :transcript_lines do |t|
      t.references :video, null: false, foreign_key: true
      t.string :text
      t.float :start
      t.float :duration

      t.timestamps
    end
  end
end
