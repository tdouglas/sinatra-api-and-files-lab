require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
  movie_file = File.new('movies.csv', "r")
  @movies = {}
  movie_file.each do |line_in_file|
    split_line = line_in_file.split(",")
    title = split_line[0]
    movie_data = split_line.shift
    @movies[title] = movie_data
  end
  movie_file.close
  erb :home
end

get '/view_movie_info/' do
  @title = params[:title]
  @img_link = ""
  @queried_movie = Imdb::Search.new(@title).movies.first
  erb :movie_info

#   File.open('movies.csv', 'a+') do |movie_file|
#     movie_file.puts ("#{@movie.title}, #{@movie.year}, #{@movie.poster}")
#   end
#   return @movie.inspect

#   return @movie.inspect
end

#can only access info in the form (within params)
#can do a request for query through IMDB
post '/add_movie/:movie_name' do
  puts @queried_movie.class
  # is the movie a fave?
    if params[:fave] == nil
    else
      file = File.new('movies.csv', 'a+')
      file.puts params[:movie_name]
      file.close
    end
    redirect '/'
  # if it's a fave add to movie csv
    # open the movie file
    # append all the movie information
    # close the movie file
  # if it's not a fave go back to '/''
end


# # * A user should be able to see a list of their favorite movies
# # * A user should be able to add new favorite movies
# # * A user should be able to view information about a favorite single movie

# post '/newmovie/' do
#   @title = param[:title]
#   @movie = Imdb::Search.new(@title).movies.first
#   File.open('movies.csv', 'a+') do |movie_file|
#     movie_file.puts ("#{@movie.title}, #{@movie.year}, #{@movie.poster}")
#   end
#   return @movie.inspect
#   erb :home
# end

# get '/example' do
#   # Use the first search result. Here I'm searching for the "Jobs" movie.
#   @my_movie = Imdb::Search.new("Jobs").movies.first
#   erb :example
# end


# # get '/' do                             #hit on homepage
# #   movie_file = File.new('movies.csv')
# #   @movies = {}
# #   movie_file.each do |line_in_file|
# #     split_line = line_in_file.split(",")
# #     title = split_line[0]
# #     @movies[title] = split_line
# #   end
# #   movie_file.close
# #   erb :movie                             #this file will be displayed
# # end

#   @search_movies = {}
#   search.each do |line_in_file|
#     movie_elements = line_in_file.split("|")
#     title = movie_elements[0]
#     movie_data = movie_elements.shift
#     movies[:title] = movie_data
#   end
#   movie_file.close

#     search = Imdb::Search.new('')

# @title = param[:title]
#   @movie = Imdb::Search.new(@title).movies.first
#   File.open('movies.csv', 'a+') do |movie_file|
#     movie_file.puts ("#{@movie.title}, #{@movie.year}, #{@movie.poster}")
#   end
#   return @movie.inspect
#   erb :home
