class  Api::V1::ApplicationController < ActionController::Base
# disable the CSRF token
  protect_from_forgery with: :null_session

  # disable cookies (no set-cookies header in response)
  # before_action :destroy_session

  # disable the CSRF token
  skip_before_action :verify_authenticity_token

  #before_action :authenticate!

  
end
