class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password, role)
    @email = email
    @password = password
    @role = role
  end

  def call
    TokenProvider.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password, :role

  def user
    user = User.find_by_email(email)

    if user 
      if user.role != role
        errors.add :user_authentication, "You need to login with a #{role} account"
      else
        return user if user.authenticate(password)
        errors.add :user_authentication, 'invalid credentials'
      end
    else
      errors.add :user_authentication, 'invalid credentials'
    end

    nil
  end
end