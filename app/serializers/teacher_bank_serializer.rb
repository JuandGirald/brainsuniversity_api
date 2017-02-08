class TeacherBankSerializer < UserSerializer
	has_one :bank_information
end