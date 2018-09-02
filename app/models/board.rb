class Board < ApplicationRecord
	has_many :board_routes
	has_many :routes,through: :board_routes
end
