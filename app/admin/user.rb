ActiveAdmin.register User do
  config.clear_sidebar_sections!

  controller do
    def update_role
      user = User.find(params[:id])
      role = Role.find(params[:role_id])
      if params[:has_role] == "false"
        user.roles << role unless user.roles.include?(role)
      else
        user.roles.delete(role)
      end
      render text: "ok"
    end
  end

  index do
    column :id
    column :dj_name
    column :email
    default_actions
  end

  form partial: "active_admin/users/form"
end
