# myapp.rb
require 'sinatra'
require_relative 'lib/search'

before do
  if request.body.size > 0
    request.body.rewind
    @params = ActiveSupport::JSON.decode(request.body.read)
  end
end

get '/' do
  send_file 'javascript/index2.html'
end

get '/hello' do
  'Hello World!'
end

post '/pc_coord' do
  data = @params

  point = {
   "lat" => data['lat'],
   "lon" => data['lon']
  }
  # calculate region
  return CalculateRegion(point)
end

post '/pc_code' do
    data = @params

    postal = data['postal_code']
    # Fetch coordinates; return pc_coord code
    point = CoordinatesFromPostalCode(postal)
    # calculate region
    return CalculateRegion(point)
end
