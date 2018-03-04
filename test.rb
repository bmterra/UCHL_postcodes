require 'nokogiri'

xml = File.open( "map/lines.kml" )

doc = Nokogiri::XML(xml)

entries = []

doc.remove_namespaces!.xpath('//Placemark').each do |node|

    nValues = {
        'isPoly' => false,
        'isPoint' => false,
        'name' => '',
        'family' => -1,
        'points' => []
    }

    node.children.each do |var|
        # Stop if empty
        next if var.content.strip.length == 0
        # Lookup content
        case var.name
        when 'name'
            xxx = var.content.strip.split('-')
            if xxx.length == 2
                nValues['family'] = xxx[0].strip.to_i
                nValues['name'] = xxx[1].strip
            else
                nValues['family'] = xxx[0].strip.to_i
                nValues['name'] = 'Area'
            end
        when 'Polygon'
            nValues['isPoly'] = true
            str_points = var.at('//Polygon/outerBoundaryIs/LinearRing/coordinates').content
            str_points = str_points.split(' ')

            str_points.each do |point|
                tmp = point.split(',')
                nValues['points'] << {
                    'lon' => tmp[0].strip.to_f,
                    'lat' => tmp[1].strip.to_f
                }
            end
        when 'Point'
            nValues['isPoint'] = true
            # lon, lat
            tmp = var.content.split(',')
            nValues['points'] << {
                'lon' => tmp[0].strip.to_f,
                'lat' => tmp[1].strip.to_f
            }
        end

    end
    # Ignore if invalid data
    unless nValues['family'] == -1
        entries << nValues
        nValues
    end
end

puts entries
