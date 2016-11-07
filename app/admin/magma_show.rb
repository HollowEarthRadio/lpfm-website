ActiveAdmin.register MagmaShow do

  config.clear_sidebar_sections!

  index do
    column :name
    column :date
    actions
  end

  form do |f|
    f.inputs "Magma Show" do
      f.input :name
      f.input :date
      f.input :link
      f.input :body
      f.input :venue
      f.input :poster_image
    end
    f.actions do
     f.action :submit
     f.action :cancel, as: :link, :label => "Cancel"
    end
  end
end
