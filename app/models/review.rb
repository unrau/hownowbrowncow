class Review < ActiveRecord::Base

  validates :title,
    presence: true,
    uniqueness: { case_sensitive: false,
                  message: "already exists. Please choose a unique title."}

  validates :text,
    presence: true

end
