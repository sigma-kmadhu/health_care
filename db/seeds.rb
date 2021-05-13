# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


company_list = [ 'Lenox Hill', 'Mount Sinai' ]
loc_arr = ["IOP3", "IOP5", "OP", "On Admit", "PHP"]

company_list.each_with_index do |company, index|
    actual_company_id = 10 + index
    company_obj = Company.create(name: company, actual_company_id: actual_company_id)
    company_obj.users.create({email: "#{company.parameterize}@gmail.com", password: 'password', password_confirmation: 'password'})
    60.times do |index|
        actual_patient_id = actual_company_id.to_s + (5000 + index).to_s
        patient_obj = company_obj.patients.create(
            name: "#{company.parameterize}_patient_#{index}", insurance_provider: "insurance_#{index}", 
            dob: Date.today-20.day, therapist: "therapist_#{index}", admit_date: Date.today, 
            loc: loc_arr[index%5], actual_patient_id: actual_patient_id.to_i)
        7.times do |dw|
            patient_obj.daywise_infos.create(t_date: Date.today - (dw+1).day)
        end
    end
end

require 'csv'
loc_services = []
csv = CSV.foreach("#{Rails.root}/loc_services.csv", :headers => true, :header_converters => lambda { |h| h.try(:downcase) })
csv.each do |row|
    loc_services << row.to_hash.symbolize_keys
end
LocServiceDd.create(loc_services)
    