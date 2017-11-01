class User < ApplicationRecord
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
end
