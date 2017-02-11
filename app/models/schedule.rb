class Schedule < ApplicationRecord
	before_save :set_duration

	belongs_to :teacher, inverse_of: :profile, dependent: :destroy
	belongs_to :student, inverse_of: :profile, dependent: :destroy

	validates :teacher, :student, presence: true
	validates :start_at, :end_at, :duration, presence: true

	private
		def set_duration
			hours = ((end_at - start_at)/1.hour).round
			self.duration = hours
		end
end
