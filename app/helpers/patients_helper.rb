module PatientsHelper
    # cache removed since the loc will be keep changing in DB by ETL team in postgres directly
    def construct_loc_services
        # Rails.cache.fetch('loc_services'){    
        #  }
        color_codes = ["#ff9999", "#9fdf9f", "#99c2ff", "#ffff99", "#dfbf9f", "#e6b3cc", "#80ffd4"]
        locs = reject_empty_from_array(LocServiceDd.pluck(:loc).uniq)
        service_hash = {}
        locs.each_with_index do |loc, index|
            service_hash[loc] = {
                services: reject_empty_from_array(LocServiceDd.where(loc: loc).pluck(:service).uniq),
                color: color_codes[index]
            }
        end
        service_hash
    end

    def reject_empty_from_array(array_obj)
        array_obj.reject { |e| e.to_s.empty? }
    end
end
