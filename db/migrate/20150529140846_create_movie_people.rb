class CreateMoviePeople < ActiveRecord::Migration
  def change
    create_table :movie_people do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
