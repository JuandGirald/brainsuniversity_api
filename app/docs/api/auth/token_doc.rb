module Api::Auth::TokenDoc
  def self.included(base)
    base.instance_eval do
      header 'Authorization', 'User auth token', :required => true
      error code: 401, desc: 'Invalid Token'
    end
  end
end