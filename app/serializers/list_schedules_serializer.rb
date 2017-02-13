class ListSchedulesSerializer < ActiveModel::Serializer
	attributes :id, :start_at, :modality, :status,
						 :duration
end