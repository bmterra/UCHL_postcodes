class Aux
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

    def orderDistance(list)
        return list.sort_by do |item| #note the exclamation mark
            item['distance']
        end
    end
    
end
