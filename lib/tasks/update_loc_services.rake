namespace :update_loc_services do
  desc "TODO"
  task add_none_loc_service: :environment do
    loc_services = [['IOP3','None'],['IOP5','None'],['OP','None'],['On Admit','None'],['PHP','None']]
    loc_services.each do |loc|
      LocServiceDd.create(loc: loc[0], service: loc[1])
    end
  end
end
