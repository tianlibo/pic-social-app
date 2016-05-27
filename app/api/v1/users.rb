module V1
  class Users < Grape::API
    version 'v1', using: :path
    format :json

    helpers V1::Helpers

    resource :users  do 

      desc 'create a new user'
      params do 
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
      end
      post :create do 
        @user = User.new  name: params[:name], email: params[:email], password: params[:password]
        if @user.save 
          { code: 0, data: {access_toke: @user.access_token}}
        else 
          { code: 1, info: @user.errors.messages}
        end
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
          { code: 0, data: {access_toke: @user.access_token}}
        else
          { code: 1, info: '账户或密码错误'}
        end
      end

      desc 'logout'
      get :logout do 
        authenticate!
        current_user.reset_access_token
        { code: 0 }
      end

      desc 'test the resource'
      get :test do 
        { resource: 'users'}
      end
    end
  end
end