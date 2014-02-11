ActiveAdmin.register User do
  config.clear_sidebar_sections!

  index do
    column :id
    column :dj_name
    column :email
    default_actions
  end

  form do |f|
    f.inputs "DJ Settings" do
      f.input :email
      f.input :dj_name
    end

    f.actions do
     f.action :submit
     f.action :cancel, as: :link, :label => "Cancel"
    end
  end #form
end
