ActiveAdmin.register Program do

  config.clear_sidebar_sections!

  controller do
    def update(options={}, &block)
      update! do |success,failure|
        success.html do
          redirect_to admin_program_path(@program)
        end
        failure.html do
          flash[:error] = @program.errors.full_messages.to_sentence
          redirect_to admin_edit_program_path(@program)
        end
      end

    end
  end

  index do
    column :id
    column :name
    default_actions
  end

  form do |f|
    f.inputs "LIVE SETTINGS" do
      f.input :is_broadcasting, hint: "This is currently not working"
      f.input :message, hint: "This is currently not working"
      f.input :broadcast_starttime, as: :hidden, input_html: { value: Time.zone.now }
    end

    f.inputs "Program" do
      f.input :name
      f.input :description
      f.input :air_times
      f.input :rebroadcast_times
      f.input :external_link_name
      f.input :external_link
      f.input :twitter_id
      f.input :archived
      f.input :program_image
      f.input :users, as: :check_boxes, collection: all_users_with_dj_role(program), hint: "If you don't see your DJ name listed, the add your username #{link_to 'here', edit_admin_user_path(current_user)}".html_safe
     end

    f.actions do
     f.action :submit
     f.action :cancel, as: :link, :label => "Cancel"
    end
  end #form
end
