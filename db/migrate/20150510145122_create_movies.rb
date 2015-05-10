class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :production
      t.date :release_date
      t.text :description

      t.timestamps null: false
    end
  end
end
