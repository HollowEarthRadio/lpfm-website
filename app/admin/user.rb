ActiveAdmin.register User do
  filter :email

  index do
    column 'Edit' do |user|
      link_to 'Edit', edit_admin_user_path(user), title: "Edit"
    end
    column "Email", sortable: :email do |u|
      link_to u.email, admin_user_path(u)
    end
    column :login
  end #index

  show do
    attributes_table_for user do
      row :id
      row :email
      row :login
    end
  end

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :login
    end
    f.actions do
      f.action :submit
      f.action :cancel, as: :link, label: "Cancel"
    end
  end
end

