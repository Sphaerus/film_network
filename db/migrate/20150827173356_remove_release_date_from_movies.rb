class RemoveReleaseDateFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :release_date
    add_column :movies, :release_date, :string
  end
end
