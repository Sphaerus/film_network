class AddOpenedToModels < ActiveRecord::Migration
  def change
    add_column :movies, :opened, :boolean, default: false
    add_column :people, :opened, :boolean, default: false
  end
end
