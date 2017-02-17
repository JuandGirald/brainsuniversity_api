class Room < ApplicationRecord
	belongs_to :schedule, inverse_of: :room
end
