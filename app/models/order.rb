class Order < ApplicationRecord
  belongs_to :schedule, dependent: :destroy

  enum status: { aceptada: '1', 
                 rechazada: '2',
                 pendiente: '3',
                 fallida: '4'
               }

  def generate_order_number
    self.number = "BR#{Time.now.year}#{Time.now.month}#{Time.now.day}#{Array.new(4){rand(9)}.join}" if self.number.blank?
    self.number
  end
end
