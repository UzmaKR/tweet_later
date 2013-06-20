get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/status/:job_id' do
  #returns the status of a job to an AJAX call
end

post '/tweet' do
  uzma = User.find(1)
  uzma.tweet(params[:status])

end

get '/auth' do
  p params
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  p @access_token
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token
  @user = User.find_by_oauth_token(@access_token.params[:oauth_token])
  unless @user
    @user = User.create(username: @access_token.params[:screen_name],
                        oauth_token: @access_token.params[:oauth_token],
                        oauth_secret: @access_token.params[:oauth_token_secret])
  end
  erb :index
  
end
