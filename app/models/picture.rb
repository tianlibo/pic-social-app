class Picture < ActiveRecord::Base
  mount_uploader :path, ImageUploader
  belongs_to :user


  scope :others, -> (user_id) { where('user_id != ?',user_id)}

  validates :path, presence: true

  class << self
    def rand_picture_except(user_id)
      @pictures = self.others(user_id)
      count = @pictures.count
      return @pictures[rand(count)]
    end
  end
end