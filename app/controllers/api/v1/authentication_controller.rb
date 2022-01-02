class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :authenticate_request, only: :authenticate

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      user = command.result
      json_response(
        success: true,
        message: "User authenticated successfully",
        data: {
          user: serialize_resource(user, serializer: UserSerializer, user: { auth_token: true })
        }
      )
    else
      json_response(
        success: false,
        message: "User authenticated successfully",
        error: command.errors
      )
    end
  end

end
