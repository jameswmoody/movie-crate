get '/sessions/new' do
  erb :'/sessions/new'
end

post '/sessions/new' do
  @user = User.find_by(email: params[:user][:email])

  if @user && @user.password == params[:user][:password]
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = ["Username & password do not match"]
    erb :'/sessions/new'
  end
end

delete '/sessions/logout' do
  session[:user_id] = nil
  redirect '/'
end
