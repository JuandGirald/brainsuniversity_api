module Api::V1::AuthDoc
  extend BaseDoc

  namespace 'api/v1'
  
  doc_for :authenticate do
    api :POST, '/session', 'Log In'
    param :email, String, :required => true
    param :password, String, :required => true
    error code: 401, desc: 'Bad credentials'
  end

  doc_for :logout do
    api :DELETE, '/session', 'Log out'
    auth_with :token
  end
end
