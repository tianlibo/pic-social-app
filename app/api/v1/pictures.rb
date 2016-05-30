module V1
  class Pictures < Grape::API
    version 'v1', using: :path
    format :json

    helpers V1::Helpers

    resource :pictures  do 
      desc 'upload the picture'
      post :create do 
        authenticate!
        @picture = Picture.new path: params[:path], user_id: current_user.id 
        return { code: 1, info: '图片上传异常'} if !@picture.save

        #随机获取一张图片
        @picture = Picture.rand_picture_except(current_user.id)
        #随机生成一个接收者
        receiver = User.rand_recerver_except(current_user.id)

        @message = Message.new sender: current_user.id, receiver: receiver, picture_id: @picture_id
        @message.save

        { code: 0, data:{path: @picture.path.thumb.url} }
      end

      desc 'test the interface'
      post :test do 
        begin 
          @picture = Picture.new path: params[:path]   
        rescue Exception => e
          logger.debug e
        end     
        return { code: 1, info: '图片上传异常'} if !@picture.save
        { code: 0, data:{path: @picture.path.thumb.url} }
      end
    end
  end
end
