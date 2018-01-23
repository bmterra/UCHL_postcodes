# myapp.rb
require 'sinatra'
require_relative 'lib/poly'
require_relative 'lib/clinics'

object = Clinics.new

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

post '/postal_code' do
  data = @params
  puts data

  point = {
   "lat" => data['lat'],
   "lon" => data['lon']
  }
  puts point

  for key in object.clinics.keys do
    poly = object.clinics[key]['poly']
    clinics = object.clinics[key]['clinics']
    region = key
    if IsPointInPolygon(point,poly)
      return [
        200,
        {'Content-Type' => 'application/json'},
        [{
          "response" => true,
          "address" => data['address'],
          "region" => key,
          "clinics" => clinics
        }].to_json
      ]
    end
  end
  # Return false
  return [
    200,
    {'Content-Type' => 'application/json'},
    [{
      "response" => false,
    }].to_json
  ]

end
