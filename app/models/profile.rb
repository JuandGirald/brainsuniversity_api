class Profile < ApplicationRecord
	belongs_to :teacher, inverse_of: :profile
	belongs_to :student, inverse_of: :profile

	validate :teacher_or_student
	validates :university, presence: { message: 'University Can not be blank' }

	private
		def teacher_or_student
			if teacher.nil? && student.nil?
				errors.add(:profile, "You need to assign a student or user for this profile")
			end
		end
end
