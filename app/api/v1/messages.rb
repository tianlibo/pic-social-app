module V1
  class Messages < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
      def logger
        Messages.logger
      end
    end

    helpers V1::Helpers

    resource :messages do
      get do
        authenticate!
        @messages = Message.without_read(current_user.id)
        { result: 'ok'}
      end

      desc 'test the interface'
      get :test do 
        { resource: 'messages'}
      end
    end
  end
end