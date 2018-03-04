require 'nokogiri'

class Clinics
    def initialize
      Hash @clinics = {}
      # List files in dir
      file_name = Dir["map/lines.kml"]

      xml = File.open( file_name )

      doc = Nokogiri::XML(xml)
      doc.remove_namespaces!.xpath('//Placemark').each do |node|


        content == points

        region_id = family

        clinics = isPoint, family x


#        if file_name.include? 'clinics'
#          if @clinics.include? region_id
#            @clinics[region_id]['clinics'] = content
#          else
#            @clinics[region_id] = {'clinics' => content}
#          end
#        else # poly
#          if @clinics.include? region_id
#            @clinics[region_id]['poly'] = content
#          else
#            @clinics[region_id] = {'poly' => content}
#          end
#        end
#      end
#    end

    def clinics
      @clinics
    end
end
