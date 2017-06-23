class Payment < ApplicationRecord
  belongs_to :order

  enum state: { aceptada: '1', 
                rechazada: '2',
                pendiente: '3',
                fallida: '4'
              }
end
