require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

set :bind, '0.0.0.0'

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/about' do
  erb :about
end

get '/new' do
  erb :form
end

post '/' do
  recipe = Recipe.new(params[:rname], params[:descr])
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/destroy/:id' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.remove_recipe(params[:id].to_i)
  redirect '/'
end

get '/done/:id' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  puts params
  cookbook.mark_done(params[:id].to_i)
  redirect '/'
end
