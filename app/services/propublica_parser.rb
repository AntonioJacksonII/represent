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

  def parse_bill(json_response, offset)
    bill = JSON.parse(json_response, symbolize_names: true)[:results].first
    bill_info = clean_bill_attributes(bill)
    bill_info[:offset] = offset
    Bill.create(bill_info)
  end

  private

  # def clean_rep_attributes(rep_hash)
  #   clean_hash = delete_unneeded_rep_attr(rep_hash)
  #   clean_hash[:govtrack_id] = clean_hash[:govtrack_id].to_i
  #   clean_hash[:district] = clean_hash[:district].to_i
  #   clean_hash[:last_updated] = clean_hash[:last_updated].to_datetime
  #   clean_hash[:dob] = clean_hash.delete(:date_of_birth)
  #   clean_hash[:congress_id] = clean_hash.delete(:id)
  #   clean_hash[:missed_votes_percentage] = clean_hash.delete(:missed_votes_pct)
  #   clean_hash[:votes_with_percentage] = clean_hash.delete(:votes_with_party_pct)
  #   clean_hash[:votes_without_party_percentage] = clean_hash.delete(:votes_against_party_pct)
  #   clean_hash
  # end
  #
  # def clean_sen_attributes(sen_hash)
  #   clean_hash = delete_unneeded_sen_attr(sen_hash)
  #   clean_hash[:govtrack_id] = clean_hash[:govtrack_id].to_i
  #   clean_hash[:last_updated] = clean_hash[:last_updated].to_datetime
  #   clean_hash[:dob] = clean_hash.delete(:date_of_birth)
  #   clean_hash[:congress_id] = clean_hash.delete(:id)
  #   clean_hash[:missed_votes_percentage] = clean_hash.delete(:missed_votes_pct)
  #   clean_hash[:votes_with_percentage] = clean_hash.delete(:votes_with_party_pct)
  #   clean_hash[:votes_without_party_percentage] = clean_hash.delete(:votes_against_party_pct)
  #   clean_hash
  # end

  def clean_bill_attributes(bill_hash)
    votes = bill_hash[:votes]
    passage_vote = votes.find { |vote| vote[:question] == "On Passage" }
    bill_hash[:passage_roll_call] = passage_vote[:roll_call]
    needed_attr = [:bill_id, :summary_short, :short_title, :congressdotgov_url,
                   :primary_subject, :passage_roll_call]
    bill_hash.delete_if {|key, value| !needed_attr.include?(key)}
    bill_hash[:congress_url] = bill_hash.delete(:congressdotgov_url)
    bill_hash
  end

  # def delete_unneeded_rep_attr(rep_hash)
  #   unneeded_attr = [:title, :short_title, :api_uri, :middle_name, :suffix,
  #                    :youtube_account, :cspan_id, :votesmart_id, :icpsr_id,
  #                    :crp_id, :google_entity_id, :fec_candidate_id, :rss_url,
  #                    :ideal_point, :seniority, :next_election, :total_present,
  #                    :ocd_id, :fax, :geoid]
  #   rep_hash.delete_if {|key, value| unneeded_attr.include?(key)}
  # end
  #
  # def delete_unneeded_sen_attr(sen_hash)
  #   unneeded_attr = [:title, :short_title, :api_uri, :middle_name, :suffix,
  #                    :youtube_account, :cspan_id, :votesmart_id, :icpsr_id,
  #                    :crp_id, :google_entity_id, :fec_candidate_id, :rss_url,
  #                    :cook_pvi, :ideal_point, :seniority, :total_present,
  #                    :ocd_id, :fax, :lis_id]
  #   sen_hash.delete_if {|key, value| unneeded_attr.include?(key)}
  # end
end
