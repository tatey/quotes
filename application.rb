require 'rubygems'
require 'sinatra'
require 'sequel'
require 'helpers'
require 'erb'

Sequel.extension :pagination
DB = Sequel.sqlite 'db/quotes.db'
%w(line quote vote).each { |file| require "models/#{file}" }

get '/' do
  @quotes = Quote.paginate(1, 30).by_recent
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
  redirect '/'
end
