class Favorite < ApplicationRecord
  belongs_to :user

  validates :uri, presence: true, uniqueness: true
end
