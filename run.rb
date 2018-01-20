require 'json'
require 'base64'
require 'openssl'
require 'net/http'
require 'geo_calc'

require 'csv'

def max (a,b)
  a>b ? a : b
end

def min (a,b)
  a<b ? a : b
end

def IsPointInPolygon( point, polygon )
  minX = polygon[0]['lon']
  maxX = polygon[0]['lon']
  minY = polygon[0]['lat']
  maxY = polygon[0]['lat']
  for i in 0..polygon.length do
    minX = min( polygon[i]['lon'], minX )
    maxX = max( polygon[i]['lon'], maxX )
    minY = min( polygon[i]['lat'], minY )
    maxY = max( polygon[i]['lat'], maxY )
  end

  if ( point['lon'] < minX || point['lon'] > maxX || point['lat'] < minY || point['lat'] > maxY )
    return false
  end

  inside = false

  for i in 0..polygon.length - 1 do
    if ( ( polygon[i]['lat'] > point['lat'] ) != ( polygon[j]['lat'] > point['lat'] ) and
          point['lon'] < ( polygon[j]['lon'] - polygon[i]['lon'] ) * ( point['lat'] - polygon[i]['lat'] ) / ( polygon[j]['lat'] - polygon[i]['lat'] ) + polygon[i]['lon'] )
      inside = !inside
    end
  end
  return inside
end



# def readCSV(filename)
#     data = CSV.read(filename, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all } )
#     return data.map { |d| d.to_hash }
# end
#
# def getLatLng(postal_code)
#     api='AIzaSyBlQB6wQrQF2bszfv3hEKKOss1MFHSAqBI'
#
#     #https://developers.google.com/maps/documentation/javascript/get-api-key#client-id
#     uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?&sensor=false&key=#{api}&components=postal_code:#{postal_code}")
#
#     request = Net::HTTP.new(uri.host, uri.port)
#     request = Net::HTTP::Get.new(uri.request_uri)
#     request["accept"] = "application/json"
#
#     http = Net::HTTP.new(uri.host, uri.port)
#     http.use_ssl = true
#     response = http.request(request)
#
#     r = JSON.parse(response.body)
#
#     # {"results"=>[
#     #   {"address_components"=>[
#     #     {"long_name"=>"N1C 4BT", "short_name"=>"N1C 4BT", "types"=>["postal_code"]},
#     #     {"long_name"=>"Kings Cross", "short_name"=>"Kings Cross", "types"=>["neighborhood", "political"]},
#     #     {"long_name"=>"London", "short_name"=>"London", "types"=>["postal_town"]},
#     #     {"long_name"=>"Greater London", "short_name"=>"Greater London", "types"=>["administrative_area_level_2", "political"]},
#     #     {"long_name"=>"England", "short_name"=>"England", "types"=>["administrative_area_level_1", "political"]},
#     #     {"long_name"=>"United Kingdom", "short_name"=>"GB", "types"=>["country", "political"]}
#     #   ],
#     #   "formatted_address"=>"Kings Cross, London N1C 4BT, UK",
#     #   "geometry"=>{"bounds"=>{"northeast"=>{"lat"=>51.5379906, "lng"=>-0.1263251}, "southwest"=>{"lat"=>51.5365016, "lng"=>-0.127554}},
#     #   "location"=>{"lat"=>51.5374518, "lng"=>-0.1268112},
#     #   "location_type"=>"APPROXIMATE",
#     #   "viewport"=>{"northeast"=>{"lat"=>51.5385950802915, "lng"=>-0.125590569708498},
#     #   "southwest"=>{"lat"=>51.5358971197085, "lng"=>-0.128288530291502}}},
#     #   "place_id"=>"ChIJaSCqtxcbdkgRmBE1hoDrXTk",
#     #   "types"=>["postal_code"]}],
#     #   "status"=>"OK"}
#
#     unless r['status'] == "OK"
#       if r.has_key?("error_message")
#         puts "Error: #{r['error_message']}"
#         return false
#       end
#     end
#
#     puts r['results'][0]['formatted_address']
#     return r['results'][0]['geometry']['location']
# end
#
# ################################################################################
# #
# ################################################################################
#
# ## clinics = readCSV("clinics.csv")
# ## # postal_code = ARGV[0].to_str
# ## # coordinates = getLatLng(postal_code)
# ## coordinates = {"lat"=>51.5374518, "lng"=>-0.1268112}
# ## puts coordinates
#
