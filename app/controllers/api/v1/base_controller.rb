class Api::V1::BaseController < ApplicationController
  include ApiAuthentication
  include ApiResponse
end
