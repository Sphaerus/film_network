class RemoveCharacters < ActiveRecord::Migration
  def change
    drop_table :characters
    drop_table :movie_characters
  end
end
