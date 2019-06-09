# myapp.rb
require 'sinatra'
require_relative 'lib/search'
require_relative 'lib/coords'
require 'json'
require 'toml'
set :views, settings.root + '/templates'

apikey = ''

if ENV['api_key']
    puts("Reading apikey from environment")
    apikey = ENV['api_key']
else
    puts("Reading apikey from config file")
    config = TOML.load_file("config.toml")
    apikey = config['google']['api_key']
end

before do
  if request.body.size > 0
    request.body.rewind
    @params = ActiveSupport::JSON.decode(request.body.read)
  end
end

get '/single' do
  @apikey = apikey
  erb :single
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
