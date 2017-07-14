get '/users/:id/movies' do
  Tmdb::Api.key(ENV["TMDB_API_KEY"])
  user = User.find(current_user.id)
  @movies = []

  if params[:search_type] == nil
    @movies = user.movies
  end

  if params[:search_type] == "title"
    search_results = Tmdb::Movie.find(params[:search])

    user.movies.each do |movie|
      search_results.each do |result|
        if movie.tmdb_id == result.id
          @movies << movie
        end
      end
    end

  elsif params[:search_type] == "actor"
    actor = Tmdb::Person.find(params[:search])[0]
    search_results = []

    Tmdb::Person.credits(actor.id)["cast"].each do |movie|
      search_results << movie
    end

    user.movies.each do |movie|
      search_results.each do |result|

        if movie.tmdb_id == result["id"]
          @movies << movie
        end
      end
    end
  end

  return erb :'movies/_container', layout: false if request.xhr?
  erb :'/movies/index'
end

get '/users/:id/movies/new' do
  Tmdb::Api.key(ENV["TMDB_API_KEY"])
  user = User.find(current_user.id)
  @movies = []

  if params[:search_type] == nil
    @movies = Tmdb::Movie.popular[0...10]
  else
    search_results = Tmdb::Movie.find(params[:search])

    search_results.each do |result|
      @movies << result
    end

    if @movies.length > 10
      @movies = @movies[0...10]
    end
  end

  erb :'/movies/new'
end

post '/users/:id/movies/new' do
  Tmdb::Api.key(ENV["TMDB_API_KEY"])
  user = User.find(current_user.id)

  new_movie = Tmdb::Movie.detail(params[:movie_id])
  saved_movie = Movie.create(tmdb_id: new_movie["id"])

  user.crate_entries.create(movie_id: saved_movie.id)
  redirect "/users/#{current_user.id}/movies"
end
