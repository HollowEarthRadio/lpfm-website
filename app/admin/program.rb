ActiveAdmin.register Program do

  form do |f|
    f.inputs "LIVE SETTINGS" do
      f.input :is_broadcasting
      f.input :message
      f.input :broadcast_starttime, as: :hidden, input_html: { value: Time.zone.now }
    end

    f.inputs "Program" do
      f.input :name
      f.input :description
      f.input :air_times
      f.input :rebroadcast_times
      f.input :external_link_name
      f.input :external_link
      f.input :archived
      f.input :program_image
      f.input :users, as: :check_boxes, :collection => Hash[User.all.map{|b| [b.dj_name,b.id]}]
    end

    f.actions do
     f.action :submit
     f.action :cancel, as: :link, :label => "Cancel"
    end
  end #form
end
