get '/users/new' do
  erb :'/users/new'
end

post '/users/new' do
  if params[:user][:password] == params[:password_confirm]
    @user = User.new(params[:user])
  end

  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:id' do
  erb :'/users/show'
end
