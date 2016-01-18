class AddRichnessToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :richness, :integer
  end
end
