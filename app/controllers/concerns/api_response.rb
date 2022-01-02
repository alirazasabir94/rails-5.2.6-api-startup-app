module ApiResponse
  def json_response(success:, message:, data: {}, error: {})
    result = {}
    result[:success] = success
    result[:message] = message
    if success.present?
      result[:data] = data
    else
      result[:error] = error
    end
    render json: result, status: :ok
  end

  def serialize_resource(resource, **options)
    ActiveModelSerializers::SerializableResource.new(resource, options)
  end
end