class AddJobToMoviePeople < ActiveRecord::Migration
  def change
    add_column :movie_people, :job, :integer
  end
end
