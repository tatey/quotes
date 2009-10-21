require 'rubygems'
require 'sinatra'
require 'yaml'
require 'sequel'
require 'helpers'
require 'erb'

yaml = YAML.load_file File.join(File.dirname(__FILE__), 'database.yml')
configure :development do
  DB = Sequel.connect(yaml['development']['uri'])
end
configure :production do
  DB = Sequel.connect(yaml['production']['uri'])
end
Sequel.extension :pagination
%w(line quote vote).each { |file| require "models/#{file}" }

enable :sessions

get '/' do
  @quotes = Quote.paginate(1, 30).by_recent
  if session[:new_quote]
    session[:new_quote] = nil
    @new_quote = true
  end
  erb :index
end

get '/quotes/page/:no' do
  @quotes = Quote.paginate(params[:no].to_i, 30).by_recent
  erb :index
end

get '/quote/new' do
  erb :new
end

post '/quotes' do
  @quote = Quote.new(params[:quote])
  if @quote.save
    session[:new_quote] = true
    redirect '/'
  else
    erb :new
  end
end

get '/quote/:id' do
  @quote = Quote[:id => params[:id]]
  erb :show
end

post '/quote/:id/votes/:vote_type' do
  quote = Quote[:id => params[:id]]
  quote.add_vote(Vote.create(:vote_type => params[:vote_type]))
  redirect "/#quote_#{quote.id}"
end
