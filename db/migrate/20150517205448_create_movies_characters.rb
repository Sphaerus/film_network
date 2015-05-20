class CreateMoviesCharacters < ActiveRecord::Migration
  def change
    create_table :movies_characters do |t|
      t.references :character, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
