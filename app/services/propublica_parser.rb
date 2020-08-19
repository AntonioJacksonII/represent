class PropublicaParser

  def initialize
    @service = SinatraService.new
  end

  def parse_house_members
    reps = @service.get_house_members[:data]
    reps.each do |rep|
      rep[:last_updated] = rep[:last_updated].to_datetime
      if rep.delete(:in_office)
        HouseMember.create(rep)
      end
    end
  end

  def update_representatives(representative)
    if representative.first.class == HouseMember
      reps_json = @service.get_house_members[:data]
    else
      reps_json = @service.get_senators[:data]
    end

    representative.all.each do |representative|
      rep_data = reps_json.find.each { |rep| rep[:congress_id] == representative.congress_id }
      rep_data[:last_updated] = rep_data[:last_updated].to_datetime
      if rep_data.delete(:in_office)
        representative.update(rep_data)
      end
    end
  end

  def parse_senators
    sens = @service.get_senators[:data]
    sens.each do |sen|
      sen[:last_updated] = sen[:last_updated].to_datetime
      if sen.delete(:in_office)
        Senator.create(sen)
      end
    end
  end

  def seed_and_update_bills
    bills = @service.get_bills[:data]
    # json_response = File.read('spec/fixtures/bills.json')
    # bills = JSON.parse(json_response, symbolize_names: true)[:data]
    bills.each do |bill_info|
      separated_info = separate_bills(bill_info)
      bill = Bill.find_or_create_by(bill_id: separated_info[0][:bill_id]) do |bill|
        bill.bill_id = separated_info[0][:bill_id]
        bill.short_title = separated_info[0][:short_title]
        bill.primary_subject = separated_info[0][:primary_subject]
        bill.summary_short = separated_info[0][:summary_short]
        bill.congress_url = separated_info[0][:congress_url]
      end
      
      bill.create_house_bill_vote(separated_info[1]) unless
        separated_info[1][:roll_call].nil? || !bill.saved_changes?
      bill.create_senate_bill_vote(separated_info[2]) unless
        separated_info[2][:roll_call].nil? || !bill.saved_changes?
      end
  end

  private

  def separate_bills(bill_info)
    house_vote_info = {}
    senate_vote_info = {}
    house_vote_info[:session] = bill_info.delete(:house_session)
    house_vote_info[:roll_call] = bill_info.delete(:house_roll_call)
    senate_vote_info[:session] = bill_info.delete(:senate_session)
    senate_vote_info[:roll_call] = bill_info.delete(:senate_roll_call)
    [bill_info, house_vote_info, senate_vote_info]
  end

end
