class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return nil if user.blank?
    user.update(auth_token: JsonWebToken.encode(user_id: user.id))
    user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.valid_password?(password)

    errors.add :authentication, 'Invalid credentials'
    nil
  end
end