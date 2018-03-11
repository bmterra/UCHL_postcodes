
def CoordinatesFromPostalCode(postal_code)
    api='AIzaSyBHmsSS0VoGB7VShQS_WGrG16anXzml4Q8'
        #https://developers.google.com/maps/documentation/javascript/get-api-key#client-id
    uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?&sensor=false&key=#{api}&components=postal_code:#{postal_code}")
    request = Net::HTTP::Get.new(uri.request_uri)
    request["accept"] = "application/json"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)
    r = JSON.parse(response.body)
         # {"results"=>[
     #   {"address_components"=>[
     #     {"long_name"=>"N1C 4BT", "short_name"=>"N1C 4BT", "types"=>["postal_code"]},
     #     {"long_name"=>"Kings Cross", "short_name"=>"Kings Cross", "types"=>["neighborhood", "political"]},
     #     {"long_name"=>"London", "short_name"=>"London", "types"=>["postal_town"]},
     #     {"long_name"=>"Greater London", "short_name"=>"Greater London", "types"=>["administrative_area_level_2", "political"]},
     #     {"long_name"=>"England", "short_name"=>"England", "types"=>["administrative_area_level_1", "political"]},
     #     {"long_name"=>"United Kingdom", "short_name"=>"GB", "types"=>["country", "political"]}
     #   ],
     #   "formatted_address"=>"Kings Cross, London N1C 4BT, UK",
     #   "geometry"=>{"bounds"=>{"northeast"=>{"lat"=>51.5379906, "lng"=>-0.1263251}, "southwest"=>{"lat"=>51.5365016, "lng"=>-0.127554}},
     #   "location"=>{"lat"=>51.5374518, "lng"=>-0.1268112},
     #   "location_type"=>"APPROXIMATE",
     #   "viewport"=>{"northeast"=>{"lat"=>51.5385950802915, "lng"=>-0.125590569708498},
     #   "southwest"=>{"lat"=>51.5358971197085, "lng"=>-0.128288530291502}}},
     #   "place_id"=>"ChIJaSCqtxcbdkgRmBE1hoDrXTk",
     #   "types"=>["postal_code"]}],
     #   "status"=>"OK"}

    unless r['status'] == "OK"
        if r.has_key?("error_message")
            puts "Error: #{r['error_message']}"
            return false
        end
    end
    return {
        'address' => r['results'][0]['formatted_address'],
        'lat'     => r['results'][0]['geometry']['location']['lat'],
        'lon'     => r['results'][0]['geometry']['location']['lng']
    }
end
