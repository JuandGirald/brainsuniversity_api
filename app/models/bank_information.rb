class BankInformation < ApplicationRecord
	belongs_to :teacher, dependent: :destroy
	validates :owner_id, :account_number, :bank_name, :account_type, 
						:owner_name, presence: true, on: [:update]
	validates_inclusion_of :account_number, in: 0..99999999999, message: 'Debe ser de 11 digitos',
											on: [:update]	
	validate :teacher					
end
