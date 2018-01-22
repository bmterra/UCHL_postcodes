# myapp.rb
require 'sinatra'

get '/' do
  send_file 'javascript/index2.html'
end

get '/hello' do
  'Hello World!'
end

post '/postal_code' do
  result = { value: 'received' }
  result.to_json
end
