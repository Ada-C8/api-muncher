class Favorite < ApplicationRecord
  belongs_to :user_id

  validates :uri, presence: true, uniqueness: true
end
