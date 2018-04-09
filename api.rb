# myapp.rb
require 'sinatra'
require_relative 'lib/search'
require_relative 'lib/coords'
require 'json'
set :views, settings.root + '/templates'

before do
  if request.body.size > 0
    request.body.rewind
    @params = ActiveSupport::JSON.decode(request.body.read)
  end
end

get '/single' do
  apikey = 'AIzaSyCiTTnFGSuXdlTcACgx5eGm9VLroAqvHds'
  erb :single, :apikey => apikey
end

get '/multi' do
  erb :multi
end

get '/' do
  erb :index
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
    place = CoordinatesFromPostalCode(postal)
    if place.is_a? String
        return Message(postal,place)
    end
    return CalculateRegion(place)
end
