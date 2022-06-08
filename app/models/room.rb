class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 30 }
  validates :price_per_day, presence: true
  validates :introduction, presence: true, length: { maximum: 50 }
  validates :image, presence: true
end
