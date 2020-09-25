require './app/services/propublica_parser'

namespace :seed_and_update_bills do
  desc 'import bills by JSON request'
  task load: :environment do

    puts 'Loading new data'

    PropublicaParser.new.seed_and_update_bills

    puts 'JSON import task complete'
  end
end
