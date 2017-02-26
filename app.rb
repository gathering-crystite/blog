require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  get '/' do
    'Hello World!'
  end

get '/download/*.*' do
  # matches /download/path/to/file.xml
  params['download/alpine-minirootfs-3.5.1-x86_64.tar.gz'] # => ["path/to/file", "xml"]
end

end