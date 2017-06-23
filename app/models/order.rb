class Order < ApplicationRecord
  belongs_to :schedule, dependent: :destroy
  has_many :payments

  enum status: { aceptada: '1', 
                 rechazada: '2',
                 pendiente: '3',
                 fallida: '4'
               }

  def generate_order_number
    self.number = "BR#{Time.now.year}#{Time.now.month}#{Time.now.day}#{Array.new(4){rand(9)}.join}" if self.number.blank?
    self.number
  end

  def process_payment(response)
    payment = payments.build(state: response["x_response"].downcase,
                   transaction_date: response["x_transaction_date"],
                   response_code: response["x_cod_response"],
                   amount: response["x_amount"]
                  )
    payment.save!
    
    if payment.aceptada?
      self.aceptada!
      schedule.confirmed!
    end
  end
end
