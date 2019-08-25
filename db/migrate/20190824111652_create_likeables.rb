class CreateLikeables < ActiveRecord::Migration[5.2]
  def change
    create_table :likeables do |t|
      t.references :video, foreign_key: true
      t.references :user, foreign_key: true
      t.integer    :status, limit: 1

      t.timestamps
    end
  end
end
