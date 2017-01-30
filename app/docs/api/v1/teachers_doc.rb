module Api::V1::TeachersDoc
  extend BaseDoc

  namespace 'api/v1'
  resource :teachers

  doc_for :show do
    api :GET, '/teachers/:id', 'Display a teacher'
    param :id, Integer, :required => true
    auth_with :token
  end

  doc_for :index do
    api :GET, '/teachers', 'Display all teachers'
  end

  doc_for :create do
    api :POST, '/teachers', 'Create a teacher'
    param :teacher, Hash, :desc => "User info", :required => true do
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