# En esta página se reciben las variables enviadas desde ePayco hacia el servidor.
# Antes de realizar cualquier movimiento en base de datos se deben comprobar algunos valores
# Es muy importante comprobar la firma enviada desde ePayco
# Ingresar  el valor de p_cust_id_cliente lo encuentras en la configuración de tu cuenta ePayco
# Ingresar  el valor de p_key lo encuentras en la configuración de tu cuenta ePayco
class EpayIntegration
  def initialize(params)
    @x_ref_payco = params['x_ref_payco']
    @x_transaction_id = params['x_transaction_id']
    @x_amount = params['x_amount']
    @x_currency_code = params['x_currency_code']
    @x_signature = params['x_signature']
    @x_response= params['x_response']
  end

  def validate_signature
    @x_signature == generate_p_signature
  end
  
  private
    def generate_p_signature
      Digest::SHA256.hexdigest(
        ENV['P_CUST_ID_CLIENTE'] + "^" + 
        ENV['P_KEY'] + "^" + 
        @x_ref_payco + "^" + 
        @x_transaction_id + "^" + 
        @x_amount + "^" + 
        @x_currency_code
      )
    end
end
