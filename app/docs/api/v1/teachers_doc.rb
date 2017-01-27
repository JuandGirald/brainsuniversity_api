module Api::V1::TeachersDoc
  extend BaseDoc

  namespace 'api/v1'
  resource :teachers

  doc_for :show do
    api :GET, '/teachers/:id', 'Display a student'
    param :id, Integer, :required => true
    auth_with :token
  end

  doc_for :create do
    api :POST, '/teachers', 'Create a Student'
    param :user, Hash, :desc => "User info", :required => true do
      param :email, String, :required => true
      param :password, String, :required => true
    end
  end

  doc_for :update do
    api :PUT, '/teachers/:id', 'Update a Student'
    param :id, Integer, :required => true
    auth_with :token
  end
end