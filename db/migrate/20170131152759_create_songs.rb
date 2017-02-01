class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name
      # t.has_one :artist, foreign_key: true
      t.belongs_to :album, foreign_key: true

      t.timestamps
    end
  end
end
