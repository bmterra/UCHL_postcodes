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

for key in object.clinics.keys do

  poly = object.clinics[key]['poly']
  clinics = object.clinics[key]['clinics']
  region = key

  #puts region, "> #{p1}", poly, IsPointInPolygon(p1,poly)
  if IsPointInPolygon(point,poly)
      puts "In region #{region}, #{clinics}"
  end
end
