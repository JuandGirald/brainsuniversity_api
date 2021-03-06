module Api::V1::UsersDoc
  extend BaseDoc

  namespace 'api/v1'
  resource :users

  doc_for :show do
    api :GET, '/users/:id', 'Display an User'
    param :id, Integer, :required => true
    auth_with :token
  end

  doc_for :index do
    api :GET, '/users', 'Display all Users'
    auth_with :token
  end

  doc_for :create do
    api :POST, '/users', 'Create an User'
    param :user, Hash, :desc => "User info", :required => true do
      param :email, String, :required => true
      param :password, String, :required => true
    end
  end

  doc_for :update do
    api :PUT, '/users/:id', 'Update an User'
    param :id, Integer, :required => true
    auth_with :token
  end

  doc_for :destroy do
    api :DELETE, '/users/:id', 'Destroy an User'
    param :id, Integer, :required => true
    auth_with :token
  end
end