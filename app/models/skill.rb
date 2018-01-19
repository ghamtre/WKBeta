class Skill < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :guest_reviews

  geocoded_by :portfolio
  after_validation :geocode, if: :portfolio_changed?

  validates :category_type, presence: true
  validates :skill_type, presence: true
  validates :day_hour, presence: true

  def cover_photo(size)
  	if self.photos.length > 0
  		self.photos[0].image.url(size)
  	else
  		"default.jpg"
  	end
  end

  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end
end
