get '/users/:id/movies' do
  user = User.find(current_user.id)
  @movies = user.movies

  Tmdb::Api.key(ENV["TMDB_API_KEY"])
  erb :'/movies/index'
end
