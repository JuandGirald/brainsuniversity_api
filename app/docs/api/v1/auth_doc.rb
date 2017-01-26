module Api::V1::AuthDoc
  extend BaseDoc

  namespace 'api/v1'
  
  doc_for :authenticate do
    api :POST, '/session', 'Log In'
    param :user, Hash, :desc => "User info", :required => true do
      param :username, String, :required => true
      param :password, String, :required => true
    end
    error code: 401, desc: 'Unauthorized'
  end

  doc_for :logout do
    api :DELETE, '/session', 'Log out'
    auth_with :token
  end
end
