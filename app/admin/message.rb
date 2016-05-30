ActiveAdmin.register Message do

  index do
    column :id
    column :sender
    column :receiver
    column :picture_id
    column :read
    actions
  end


end
