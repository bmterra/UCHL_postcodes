require_relative 'clinics'
require_relative 'aux'
require_relative 'poly'

def CalculateRegion(point)
    object = Clinics.new

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
              'response' => true,
              'query'    => point['query'],
              'address'  => point['address'],
              'region'   => key,
              'clinics'  => aux.orderDistance(cList)
            }.to_json
          ]
      end
    end

    # Else, return false
    return [
      200,
      {'Content-Type' => 'application/json'},
      {
        'response' => false,
        'query'    => point['query'],
        'address'  => point['address'],
        'message'  => 'Outside'
      }.to_json
    ]
end


def Message(postal,message)
    return [
      200,
      {'Content-Type' => 'application/json'},
      {
          'response' => true,
          'query'    => postal,
          'message'  => message
      }.to_json
    ]
end
