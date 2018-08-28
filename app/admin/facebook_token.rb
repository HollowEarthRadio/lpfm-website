ActiveAdmin.register_page "Facebook Token" do
  page_action(:store_token) do
    binding.pry
    puts "save token"
    #TODO Chris, save the token here
    #FacebookToken.create(access_token: blah, refresh_token: blah)
    #
    # To get the latest token, use FacebookToken.latest
    redirect_to "/admin/facebook_token"
  end

  content title: 'Get Token' do
    section do
      div do
        "HI"
      end
    end
  end
end
