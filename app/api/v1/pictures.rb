module V1
  class Pictures < Grape::API
    version 'v1', using: :path
    format :json

    helpers do 
      def logger
        Pictures.logger
      end
    end

    helpers V1::Helpers

    resource :pictures  do 
      desc 'upload the picture'
      post :create do 
        @picture = Picture.new path: params[:path]
        begin
          @picture.save
        rescue => e
          logger.debug e.message
        end

        #随机获取一张图片
        # @picture = Picture.rand_picture_except(current_user.id)
        @picture = Picture.rand_picture_except(1)
        #随机生成一个接收者
        # receiver = User.rand_recerver_except(current_user.id)
        receiver = User.rand_recerver_except(1)

        @message = Message.new sender: current_user.id, receiver: receiver, picture_id: @picture_id
        @message.save
        { path: @picture.path.thumb.url }
      end

      desc 'test the interface'
      get :test do 
        { resource: 'pictures'}
      end
    end
  end
end
