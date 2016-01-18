class AddSweetnessToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :sweetness, :integer
  end
end
