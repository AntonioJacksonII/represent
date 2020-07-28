require './app/services/propublica_parser'

namespace :update_reps do
  desc 'import members and senators by JSON request'
  task load: :environment do

    model_objects = [HouseMember, Senator]

    puts 'Updating house_members and senators'
    parser = PropublicaParser.new

    model_objects.each do |model|
      parser.update_representatives(model)
    end 

    puts 'JSON update task complete'
  end
end