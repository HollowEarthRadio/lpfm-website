ActiveAdmin.register Sponsor do
  config.clear_sidebar_sections!

  index do
    column :id
    column :name
    column :link
    column :year
  end

  form do |f|
    f.inputs "Sponsor" do
      f.input :name
      f.input :link
      f.input :year
    end

    f.actions do
     f.action :submit
     f.action :cancel, as: :link, :label => "Cancel"
    end
  end #form
end
