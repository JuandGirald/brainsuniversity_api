module Api::V1::StudentsDoc
  extend BaseDoc

  namespace 'api/v1'
  resource :students

  doc_for :show do
    api :GET, '/students/:id', 'Display a student'
    param :id, Integer, :required => true
    auth_with :token
  end

  doc_for :create do
    api :POST, '/students', 'Create a Student'
    param :user, Hash, :desc => "User info", :required => true do
      param :email, String, :required => true
      param :password, String, :required => true
    end
  end

  doc_for :update do
    api :PUT, '/students/:id', 'Update a Student'
    param :id, Integer, :required => true
    auth_with :token
  end
end