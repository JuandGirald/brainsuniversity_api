module TokenProvider  
  class << self
    def issue_token(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def valid?(token)
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base)
      rescue
        nil
      end
    end
  end
end 