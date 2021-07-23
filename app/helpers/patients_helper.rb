require 'csv'

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

    # create new patient report after submit
    def init_patients_report
        file_path = File.join(Rails.root, "tmp/patient_report_#{Time.now.to_i}.csv")
        headers = ['Patient Name', 'Insurance Provide', 'Date Of Birth', 'Therapist', 'Admit Date', 'LOC']
        @company.patients.first.daywise_infos.each do |daywise_info|
            headers << "#{daywise_info.t_date.strftime('%m/%d/%Y')} (#{daywise_info.t_date.strftime("%A")})"
        end
        csv_file = CSV.open(file_path, 'wb') do |csv|
            csv << headers
        end
        csv_file
    end

    def construct_report_records(report)
        report_path = report.path
        CSV.open(report_path, 'ab') do |csv|
            @company.patients.each do |patient|
                content = ["#{patient.name}", "#{patient.insurance_provider}", "#{patient.dob.strftime('%m/%d/%Y')}", "#{patient.therapist}", "#{patient.admit_date.strftime('%m/%d/%Y')}", "#{patient.loc}"]
                patient.daywise_infos.each do |daywise_info|
                    content << daywise_info.status.split(',').join(',')
                end
                csv << content
            end
        end
        return report
    end

    def get_number_weeks(company)
        dates_list = []
        last_submitted_date = company.last_updated_at.to_date.beginning_of_week
        today = Date.today
        dates = (last_submitted_date..today).select{|x| Date::DAYNAMES[x.wday] == Date::DAYNAMES[last_submitted_date.wday] }
        dates.each do |date|
            dates_list << ["#{date.strftime('%B %d')} to #{(date+6.days).strftime('%B %d')}", date]
        end
        dates_list
    end
end
