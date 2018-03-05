require 'nokogiri'

class Clinics
    def initialize
      Hash @clinics = {}
      # List files in dir
      xml = File.open( "map/lines.kml" )
      doc = Nokogiri::XML(xml)

      entries = []

      doc.remove_namespaces!.xpath('//Placemark').each do |node|
          nValues = {
              'isPoly' => false,
              'isPoint' => false,
              'name' => '',
              'region_id' => -1,
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
                      nValues['region_id'] = xxx[0].strip.to_i
                      nValues['name'] = xxx[1].strip
                  else
                      nValues['region_id'] = xxx[0].strip.to_i
                      nValues['name'] = 'Area'
                  end
              when 'Polygon'
                  nValues['isPoly'] = true
                  nValues['points'] = Array.new
                  str_points = var.at('outerBoundaryIs/LinearRing/coordinates').content
                  #puts str_points
                  #puts var.first_element_child.first_element_child.children.at('coordinates').content
                  str_points = str_points.split(' ')

                  str_points.each do |point|
                      tmp = point.split(',')
                      nValues['points'] << {
                          'lon' => tmp[0].strip.to_f,
                          'lat' => tmp[1].strip.to_f
                      }
                  end
                  #puts ">> #{nValues['points']}"
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
          unless nValues['region_id'] == -1 or nValues['region_id'] == 0
              entries << {
                  'isPoly' => nValues['isPoly'],
                  'isPoint' => nValues['isPoint'],
                  'name' => nValues['name'],
                  'region_id' => nValues['region_id'],
                  'points' => Array.new(nValues['points'])
              }
          end
      end

      ################
      # New structure
      ################
      entries.each do | entry |
          region_id = entry['region_id']
          # Check if region is already in place
          if @clinics.include? region_id
              if entry['isPoint']
                  @clinics[region_id]['clinics'] << {
                      'name' => entry['name'],
                      'lat'  => entry['points'][0]['lat'],
                      'lon'  => entry['points'][0]['lon']
                  }
              else
                  @clinics[region_id]['poly'] = entry['points'].clone
              end
          else
              if entry['isPoint']
                  @clinics[region_id] = {
                      'clinics' => [{
                          'name' => entry['name'],
                          'lat'  => entry['points'][0]['lat'],
                          'lon'  => entry['points'][0]['lon'],
                      }],
                  }
              else
                  @clinics[region_id] = {
                      'clinics' => [],
                      'poly' => entry['points']
                  }
              end
          end
      end
  end

  def clinics
    @clinics
  end

end
