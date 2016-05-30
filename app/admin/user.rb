ActiveAdmin.register User do
  
  index do
    column :id
    column :name
    column :email
    actions
  end

end
