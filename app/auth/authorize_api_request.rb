class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    if @user.present?
      if @user.auth_token == http_auth_header
        @user
      else
        errors.add(:auth_token, 'Old token') && nil
      end
    else
      @user || errors.add(:auth_token, 'Invalid token') && nil
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:auth_token, 'Missing token')
    end
    nil
  end
end