class Profile < ApplicationRecord
	belongs_to :teacher, inverse_of: :profile, dependent: :destroy
	belongs_to :student, inverse_of: :profile, dependent: :destroy

	validate :teacher_or_student
	validates :university, :dob, :phone, 
						:gender, :city, :country, :level, :about, 
						:rate, presence: true, on: [:update]

	private
		def teacher_or_student
			if teacher.nil? && student.nil?
				errors.add(:profile, "You need to assign a student or user for this profile")
			end
		end
end
