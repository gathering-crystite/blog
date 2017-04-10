require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, 'public'
  end


get '/' do
  erb :index
end

get '/about' do
  erb :about
end

set :foo, 'bar'

get '/foo' do
  "foo is set to " + settings.foo
end


end