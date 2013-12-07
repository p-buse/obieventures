class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
before_filter :http_basic_authenticate

def http_basic_authenticate
  authenticate_or_request_with_http_basic do |username, password|
    username == "99username" && password == "password99"
  end
end
  protect_from_forgery with: :exception
end
