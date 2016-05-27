module V1
  class Users < Grape::API
    version 'v1', using: :path
    format :json

    helpers do 
      def logger
        Users.logger
      end
    end

    helpers V1::Helpers

    resource :users  do 

      desc 'create a new user'
      params do 
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
      end
      post :create do 
        logger.debug params
        # @user = User.new  name: params[:name], email: params[:email], password: params[:password]
        # @user.save
        { result: 'create success'}
      end

      desc 'login'
      params do 
        requires :email, type: String
        requires :password, type: String
      end
      post :login do 
        @user = User.where('lower(email) = lower(?)',params[:email]).first
        if @user && @user.authenticate(params[:password])
          @user.reset_access_token
          { result: 'success'}
        else
          { result: 'failed'}
        end
      end

      desc 'test the resource'
      get :test do 
        { resource: 'users'}
      end
    end

  end
end