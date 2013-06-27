require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  search = Imdb::Search.new('movies.csv')
  @search_movies = {}
  search.each do |line_in_file|
    split_line = line_in_file.split("|")
    title = split_line[0]
    movie_data = split_line.shift
    split_line[:title] = movie_data
  end
  movie_file.close
  erb :home
end

get '/view_movie_info' do
  erb :movie_info
end

get '/add_movie' do
  erb :movie_info
end

get '/list_movies' do
  erb :all_fave_movies
end

# * A user should be able to see a list of their favorite movies
# * A user should be able to add new favorite movies
# * A user should be able to view information about a favorite single movie

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