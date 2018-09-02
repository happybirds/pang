class Route < ApplicationRecord
	has_many :board_routes
	has_many :boards,through: :board_routes
end
