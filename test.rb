require_relative 'lib/clinics'
require_relative 'lib/poly'
require 'pp'

object = Clinics.new

point = {
 'lat' => 51.519840,
 'lon' => -0.137424
 }


# point = {
#     "lon"=>-0.1466417, "lat"=>51.5567423
#  }
#

def distance(point1,point2)
    lat1 = point1['lat']
    lat2 = point2['lat']

    lon1 = point1['lon']
    lon2 = point2['lon']


    r = 6371e3

    lat1rad = lat1 * Math::PI / 180
    lat2rad = lat2 * Math::PI / 180
    dlat = (lat2-lat1) * Math::PI / 180
    dlon = (lon2-lon1) * Math::PI / 180

    a = Math.sin(dlat/2) * Math.sin(dlat/2) +
            Math.cos(lat1rad) * Math.cos(lat2rad) *
            Math.sin(dlon/2) * Math.sin(dlon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return r * c;
end


for key in object.clinics.keys do
  poly = object.clinics[key]['poly']
  clinics = object.clinics[key]['clinics']
  region = key

  #puts region, "> #{p1}", poly, IsPointInPolygon(p1,poly)
  if IsPointInPolygon(point,poly)
      puts "In region #{region}, #{clinics}"

      clinics.each do |clinic|
          xd = point['lat'] - clinic['lat']
          yd = point['lon'] - clinic['lon']
          dist = distance(point,clinic)
          puts "#{clinic['name']} #{dist}"
      end
      break
  end
end
