# myapp.rb
require 'sinatra'
require_relative 'lib/poly'
require_relative 'lib/clinics'
require_relative 'lib/aux'

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

  for key in object.clinics.keys do
    poly = object.clinics[key]['poly']
    clinics = object.clinics[key]['clinics']
    region = key
    if IsPointInPolygon(point,poly)
        cList = []
        aux = Aux.new

        clinics.each do |clinic|
            xd = point['lat'] - clinic['lat']
            yd = point['lon'] - clinic['lon']
            dist = aux.distance(point,clinic)
            cList.push({
                'name' => clinic['name'],
                'distance' => dist
            })
        end

        return [
          200,
          {'Content-Type' => 'application/json'},
          {
            "response" => true,
            "address"  => data['address'],
            "region"   => key,
            "clinics"  => aux.orderDistance(cList)
          }.to_json
        ]
    end
  end

  # Else, return false
  return [
    200,
    {'Content-Type' => 'application/json'},
    [{
      "response" => false,
    }].to_json
  ]

end
