# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


company_list = %w[Apollo Fortis AIIMS]

company_list.each do |company|
    company_obj = Company.create(name: company)
    company_obj.users.create({email: "#{company}@gmail.com", password: 'password', password_confirmation: 'password'})
    60.times do |index|
        patient_obj = company_obj.patients.create(
            name: "#{company}_patient_#{index}", insurance_provider: "insurance_#{index}", 
            dob: Date.today-20.day, therapist: "therapist_#{index}", admit_date: Date.today, 
            loc: "LOC_#{index}")
        7.times do |dw|
            patient_obj.daywise_infos.create(t_date: Date.today - (dw+1).day, status: "PHP")
        end
    end
end

patient_status_dd = [ 'On Admit','PHP','IOP3','IOP5' ]
patient_status_dd.each do |dd| PatientStatusDd.create(name: dd) end