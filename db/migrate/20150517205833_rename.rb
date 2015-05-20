class Rename < ActiveRecord::Migration
  def self.up
    rename_table :movies_characters, :movie_characters
  end

 def self.down
    rename_table :movie_characters, :movies_characters
 end
end
