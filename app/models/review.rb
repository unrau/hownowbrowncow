class Review < ActiveRecord::Base

  validates :title,
    presence: true,
    uniqueness: { case_sensitive: false,
                  message: "already exists. Please choose a unique title."}

  validates :text,
    presence: true

  validates :creaminess,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10
    }

  validates :sweetness,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10
    }

  validates :richness,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10
    }

end
