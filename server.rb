require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'logger' 

@@cache = {"123" => "test"}

configure do 
  Log = Logger.new("sinatra.log")
  Log.level  = Logger::INFO 
end

get "/" do
  erb :index
end

get "/statuses/oembed/:tweet" do 
  if not @@cache[params[:tweet]]
    url = "http://api.twitter.com/1/statuses/oembed.json?id=" + params[:tweet]
    open(URI(url)) do |http|
       @@cache[params[:tweet]] = http.read
    end
  end

  return @@cache[params[:tweet]]
end
