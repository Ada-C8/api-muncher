class Favorite < ApplicationRecord
  belongs_to :user

  validates :uri, presence: true, uniqueness: true
  validates :label, presence: true
  validates :source, presence: true
end
