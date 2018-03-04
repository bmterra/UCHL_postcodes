require 'csv'

class Clinics_from_csv
    def initialize
      Hash @clinics = {}
      # List files in dir
      Dir["regions/*.csv"].each do |file_name|
        # puts file_name
        csv_text = File.read(file_name)
        csv = CSV.parse(csv_text, :headers => true)
        content = []
        csv.each do |row|
          r = row.to_hash
          r['lat'] = r['lat'].to_f
          r['lon'] = r['lon'].to_f
          content << r
        end

        region_id = file_name[8..10]
        if file_name.include? 'clinics'
          if @clinics.include? region_id
            @clinics[region_id]['clinics'] = content
          else
            @clinics[region_id] = {'clinics' => content}
          end
        else # poly
          if @clinics.include? region_id
            @clinics[region_id]['poly'] = content
          else
            @clinics[region_id] = {'poly' => content}
          end
        end
      end
    end

    def clinics
      @clinics
    end
end
