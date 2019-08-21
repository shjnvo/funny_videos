class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :titel
      t.integer :user_id
      t.string :description
      t.string :uuid
      t.string :video_url

      t.timestamps
    end
  end
end
