require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  erb :home
end

get '/view_movie_info/:title' do
  @title = params[:title]
  @img_link = ""
 # look up movie in imdb
 # display movie info

  erb :movie_info

end

get '/add_movie/:movie_name' do
  @title = params[:movie_name]
  # is the movie a fave?
  # if it's a fave add to movie csv
    # open the movie file
    # append all the movie information
    # close the movie file
  # if it's not a fave go back to '/''
  erb :movie_info
end

get '/list_movies' do
  erb :all_fave_movies
end

# * A user should be able to see a list of their favorite movies
# * A user should be able to add new favorite movies
# * A user should be able to view information about a favorite single movie

post '/newmovie/' do
  @title = param[:title]
  @movie = Imdb::Search.new(@title).movies.first
  File.open('movies.csv', 'a+') do |movie_file|
    movie_file.puts ("#{@movie.title}, #{@movie.year}, #{@movie.poster}")
  end
  return @movie.inspect
  erb :home
end

get '/example' do
  # Use the first search result. Here I'm searching for the "Jobs" movie.
  @my_movie = Imdb::Search.new("Jobs").movies.first
  erb :example
end


# get '/' do                             #hit on homepage
#   movie_file = File.new('movies.csv')
#   @movies = {}
#   movie_file.each do |line_in_file|
#     split_line = line_in_file.split(",")
#     title = split_line[0]
#     @movies[title] = split_line
#   end
#   movie_file.close
#   erb :movie                             #this file will be displayed
# end

  # @search_movies = {}
  # search.each do |line_in_file|
  #   movie_elements = line_in_file.split("|")
  #   title = movie_elements[0]
  #   movie_data = movie_elements.shift
  #   movies[:title] = movie_data
  # end
  # movie_file.close

    search = Imdb::Search.new('')
