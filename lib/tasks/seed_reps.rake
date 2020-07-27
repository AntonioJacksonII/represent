require './app/models/object_creator'
require 'pry'

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
    
    creator = ObjectCreator.new
    
    creator.create_members
    creator.create_senators
    
    puts 'JSON import task complete'
  end
end
