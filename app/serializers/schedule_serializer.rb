class ScheduleSerializer < ActiveModel::Serializer
	attributes :id, :start_at, :modality, :status,
						 :duration

	belongs_to :student
	belongs_to :teacher
end