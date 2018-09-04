require 'erb'

include ERB::Util

ActiveAdmin.register_page "Facebook Token" do
  page_action(:store_token) do
    auth = request.env['omniauth.auth']

    # Sets 60 day auth token
    oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
    new_access_info = oauth.exchange_access_token_info auth.credentials.token

    new_access_token = new_access_info["access_token"]
    new_access_expires_at = DateTime.now + new_access_info["expires"].to_i.seconds

    FacebookToken.create(access_token: new_access_token, refresh_token: "");

    redirect_to "/admin/facebook_token"    
  end

  content title: 'Facebook Admin' do
    section do
      div do
        if current_user && current_user.facebook?
          button_to 'Update Token', '/auth/facebook'
        else
          'You must be a Facebook Admin to use this page'
        end
      end
    end
  end
end
