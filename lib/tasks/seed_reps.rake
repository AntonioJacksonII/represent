require './app/services/propublica_parser'

namespace :seed_reps do
  desc 'import members and senators by JSON request'
  task load: :environment do
    model_objects = [HouseMember, Senator]
    puts 'Now deleting all HouseMember and Senator records'
    model_objects.each(&:destroy_all)
    puts 'Database is now reset'
    puts 'Loading new data'
    ActiveRecord::Base.connection.reset_pk_sequence!("house_members")
    ActiveRecord::Base.connection.reset_pk_sequence!("senators")
    parser = PropublicaParser.new
    parser.parse_house_members
    parser.parse_senators
    puts 'JSON import task complete'
  end
end
