class AddRoleNameToMoviePeople < ActiveRecord::Migration
  def change
    add_column :movie_people, :role_name, :string
  end
end
