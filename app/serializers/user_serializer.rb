class UserSerializer < ApplicationSerializer
  attributes :name, :email
  attribute :auth_token, :if => :auth_token?

  def auth_token?
    @instance_options.dig(:user, :auth_token).present?
  end
end
