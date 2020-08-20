require './app/services/propublica_parser'

desc "This task is called by the Heroku scheduler add-on"
task :update_representatives => :environment do
model_objects = [HouseMember, Senator]

  puts 'Updating house_members and senators'
  parser = PropublicaParser.new

  model_objects.each do |model|
    parser.update_representatives(model)
  end 

  puts 'JSON update task complete'
end

task :seed_bills => :environment do
  puts 'Loading new data'

  PropublicaParser.new.seed_and_update_bills

  puts 'JSON import task complete'
end
