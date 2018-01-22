require_relative 'lib/poly'
require_relative 'lib/clinics'

require 'pp'

# 1. list files
# 2. read files to mem
# 3. wait for call
# 4.

# Class runEngine {
#
#     Hash dataset
#
#    Function loadFiles {
#      # List files in dir
#      Dir["regions/*.csv"].each do |file_name|
#        puts file_name
#      end
#      # Load files to dataset
#    }
#
#    Function checkPoint(lat,lon) {
#      point = { 'lat' => lat,
#                'lon' => lon
#              }
#       # for each dataset poly
#
#      if IsPointInPolygon(point,poly) {
#        # poly
#        return clinics
#      }
#    }
#
# }
#
#
#
# poly = [
#   { 'lat' => 0,
#     'lon' => 0
#   },
#   { 'lat' => 2,
#     'lon' => 0
#   },
#   { 'lat' => 0,
#     'lon' => 2
#   },
#   { 'lat' => 2,
#     'lon' => 2
#   }
# ]
#
#puts IsPointInPolygon(point,poly)

object = Clinics.new

pp object.clinics


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
