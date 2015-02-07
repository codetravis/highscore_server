require 'sinatra'

get '/' do
    response.headers['Access-Control-Allow-Origin'] = *
    "High Score List"
end

post '/' do
     "Do nothing"
end