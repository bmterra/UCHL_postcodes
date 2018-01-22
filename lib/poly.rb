require 'json'
require 'base64'
require 'openssl'
require 'net/http'
require 'geo_calc'

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
  for i in polygon do
    minX = min( i['lon'], minX )
    maxX = max( i['lon'], maxX )
    minY = min( i['lat'], minY )
    maxY = max( i['lat'], maxY )
  end

  if ( point['lon'] < minX || point['lon'] > maxX || point['lat'] < minY || point['lat'] > maxY )
    return false
  end

  inside = false

  i=0
  j=polygon.length-1
  while i<polygon.length do
    if ( ( polygon[i]['lat'] > point['lat'] ) != ( polygon[j]['lat'] > point['lat'] ) and
        point['lon'] < ( polygon[j]['lon'] - polygon[i]['lon'] ) * ( point['lat'] - polygon[i]['lat'] ) / ( polygon[j]['lat'] - polygon[i]['lat'] ) + polygon[i]['lon'] )
        inside = !inside
    end
    j=i
    i=i+1
  end

  return inside
end
