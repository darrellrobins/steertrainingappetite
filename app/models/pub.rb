class Pub < ActiveRecord::Base
	validates :name, presence: true, uniqueness: {scope: :address}
	validates :address, presence: true, uniqueness: {scope: :name}
	validates :latitude, presence: true
	validates :longitude, presence: true

	geocoded_by :address
	before_validation :geocode

	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode
end
