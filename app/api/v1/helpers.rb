module V1
  module Helpers
    def current_user
      access_token = request.headers['Authorization']
      @current_user ||= User.find_by_access_token(access_token) if !access_token.blank?
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def logger(message)
      puts "this is logger : #{message}"
    end
  end
end