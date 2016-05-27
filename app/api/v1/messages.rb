module V1
  class Messages < Grape::API
    version 'v1', using: :path
    format :json

    helpers V1::Helpers

    resource :messages do
      get do
        authenticate!
        @messages = Message.without_read(current_user.id)
        { code:0, data: @messages.to_json}
      end

      desc 'test the interface'
      get :test do
        { resource: 'messages'}
      end
    end
  end
end