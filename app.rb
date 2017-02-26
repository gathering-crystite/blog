require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  get '/' do
    'Hello Megan!'
  end

  get '/hello/:name' do
  	# matches "GET /hello/bar"
  	# params['name'] is 'foo' or 'bar'
  	"Hello #{params['name']}!"
  end

end