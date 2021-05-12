module PatientsHelper
    def construct_loc_services
        Rails.cache.fetch('loc_services'){
            locs = LocServiceDd.pluck(:loc).uniq
            service_hash = {}
            locs.each do |loc|
                priority_loc = LocServiceDd.where(loc: loc).pluck(:service) 
                non_priority_loc = LocServiceDd.where.not(loc: loc).pluck(:service)
                loc_service = priority_loc + non_priority_loc
                service_hash[loc] = loc_service.flatten.uniq
            end
            service_hash
         }
    end
end
