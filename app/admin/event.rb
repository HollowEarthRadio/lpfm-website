ActiveAdmin.register Event do

  form do |f|
    f.inputs "Event" do
      f.input :name
      f.input :body
      f.input :public
      f.input :event_image
    end

    f.actions do
     f.action :submit
     f.action :cancel, as: :link, :label => "Cancel"
    end
  end #form
end
