class AddCreaminessToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :creaminess, :integer
  end
end
