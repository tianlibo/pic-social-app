class Message < ActiveRecord::Base

  scope :without_read, -> (user_id) { where('receiver = ? and read = ?',user_id,false)}

  def already_read
    update read: true
  end
end