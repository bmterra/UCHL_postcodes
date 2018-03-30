
def CoordinatesFromPostalCode(postal_code)
    api='AIzaSyBHmsSS0VoGB7VShQS_WGrG16anXzml4Q8'
    #https://developers.google.com/maps/documentation/javascript/get-api-key#client-id
    #uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?&sensor=false&key=#{api}&components=postal_code:#{postal_code}")
    uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?&sensor=false&key=#{api}&address='London #{postal_code}, UK'")
    request = Net::HTTP::Get.new(uri.request_uri)
    request["accept"] = "application/json"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)
    r = JSON.parse(response.body)
    unless r['status'] == "OK"
        if r.has_key?("error_message")
            return r['error_message']
        elsif r['results'].length == 0
            return "No results reported"
        end
    end
    return {
        'query'   => postal_code,
        'address' => r['results'][0]['formatted_address'],
        'lat'     => r['results'][0]['geometry']['location']['lat'],
        'lon'     => r['results'][0]['geometry']['location']['lng']
    }
end
