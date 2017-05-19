class BankInformation < ApplicationRecord
	belongs_to :teacher, dependent: :destroy
	validates :owner_id, :account_number, :bank_name, :account_type, 
						:owner_name, presence: true, on: [:update]
  validates_length_of :account_number, :minimum => 8, :maximum => 11, message: 'Debe estar entre 8 y 11 dígitos',
                      on: [:update]             
	validate :teacher					
end
