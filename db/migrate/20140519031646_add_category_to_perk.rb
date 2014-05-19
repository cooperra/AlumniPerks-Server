class AddCategoryToPerk < ActiveRecord::Migration
  def change
    add_column :perks, :category, :string
  end
end
