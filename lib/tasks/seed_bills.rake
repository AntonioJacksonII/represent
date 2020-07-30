require './app/services/propublica_parser'

namespace :seed_bills do
  desc 'import bills by JSON request'
  task load: :environment do

    puts 'Now resetting all Bill records'
    Bill.destroy_all
    puts 'Database is now reset'
    puts 'Loading new data'

    ActiveRecord::Base.connection.reset_pk_sequence!("bills")

    parser = PropublicaParser.new
    parser.parse_bills

    puts 'JSON import task complete'
  end
end
