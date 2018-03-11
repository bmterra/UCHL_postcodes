# myapp.rb
require 'sinatra'
require_relative 'lib/search'
require_relative 'lib/coords'
require 'json'
before do
  if request.body.size > 0
    request.body.rewind
    @params = ActiveSupport::JSON.decode(request.body.read)
  end
end

get '/single' do
  send_file 'javascript/single.html'
end

get '/multi' do
  send_file 'javascript/mult.html'
end

get '/hello' do
  'Hello World!'
end

post '/pc_coord' do
  data = @params
  point = {
   "address" => data['address'],
   "lat" => data['lat'],
   "lon" => data['lon']
  }
  return CalculateRegion(point)
end

post '/pc_code' do
    data = @params
    postal = data['postal_code']
    point = CoordinatesFromPostalCode(postal)
    return CalculateRegion(point)
end
