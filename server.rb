require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'logger' 

@@cache_timer = Time.now - 30*60
@@respons = ""

configure do 
  Log = Logger.new("sinatra.log")
  Log.level  = Logger::INFO 
end

get "/" do
  erb :index
end

get "/statuses/oembed/:tweet" do 
  if Time.now > @@cache_timer + 15*60
    url = "http://api.twitter.com/1/statuses/oembed.json?id=" + params[:tweet]
    Log.info url
    open(URI(url)) do |http|
      @@respons = http.read
    end
    @@cache_timer = Time.now
  end

  return @@respons
end
