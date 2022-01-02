module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
    before_action :authenticate_request
    skip_before_action :verify_authenticity_token
  end

  def authenticate_request
    command = AuthorizeApiRequest.call(request.headers)
    @current_user = command.result
    json_response(success: false, message: 'Not Authorized', error: command.errors) unless @current_user
  end
end

