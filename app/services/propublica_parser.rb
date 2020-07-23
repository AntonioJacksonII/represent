class PropublicaParser

  def initialize(json_response)
    @response = JSON.parse(json_response, symbolize_names: true)
  end

  def parse_house_members
    reps = @response[:results].first[:members]
    reps.each do |rep|
      rep_info = clean_rep_attributes(rep)
      if rep_info.delete(:in_office)
        HouseMember.create(rep_info)
      end
    end
  end

  def parse_senators
    sens = @response[:results].first[:members]
    sens.each do |sen|
      sen_info = clean_sen_attributes(sen)
      if sen_info.delete(:in_office)
        Senator.create(sen_info)
      end
    end
  end

  private

  def clean_rep_attributes(rep_hash)
    clean_hash = delete_unneeded_rep_attr(rep_hash)
    clean_hash[:govtrack_id] = clean_hash[:govtrack_id].to_i
    clean_hash[:district] = clean_hash[:district].to_i
    clean_hash[:last_updated] = clean_hash[:last_updated].to_datetime
    clean_hash[:dob] = clean_hash.delete(:date_of_birth)
    clean_hash[:congress_id] = clean_hash.delete(:id)
    clean_hash[:missed_votes_percentage] = clean_hash.delete(:missed_votes_pct)
    clean_hash[:votes_with_percentage] = clean_hash.delete(:votes_with_party_pct)
    clean_hash[:votes_without_party_percentage] = clean_hash.delete(:votes_against_party_pct)
    clean_hash
  end

  def clean_sen_attributes(sen_hash)
    clean_hash = delete_unneeded_sen_attr(sen_hash)
    clean_hash[:govtrack_id] = clean_hash[:govtrack_id].to_i
    clean_hash[:last_updated] = clean_hash[:last_updated].to_datetime
    clean_hash[:dob] = clean_hash.delete(:date_of_birth)
    clean_hash[:congress_id] = clean_hash.delete(:id)
    clean_hash[:missed_votes_percentage] = clean_hash.delete(:missed_votes_pct)
    clean_hash[:votes_with_percentage] = clean_hash.delete(:votes_with_party_pct)
    clean_hash[:votes_without_party_percentage] = clean_hash.delete(:votes_against_party_pct)
    clean_hash
  end

  def delete_unneeded_rep_attr(rep_hash)
    unneeded_attr = [:title, :short_title, :api_uri, :middle_name, :suffix,
                     :youtube_account, :cspan_id, :votesmart_id, :icpsr_id,
                     :crp_id, :google_entity_id, :fec_candidate_id, :rss_url,
                     :ideal_point, :seniority, :next_election, :total_present,
                     :ocd_id, :fax, :geoid]
    rep_hash.delete_if {|key, value| unneeded_attr.include?(key)}
  end

  def delete_unneeded_sen_attr(sen_hash)
    unneeded_attr = [:title, :short_title, :api_uri, :middle_name, :suffix,
                     :youtube_account, :cspan_id, :votesmart_id, :icpsr_id,
                     :crp_id, :google_entity_id, :fec_candidate_id, :rss_url,
                     :cook_pvi, :ideal_point, :seniority, :total_present,
                     :ocd_id, :fax, :lis_id]
    sen_hash.delete_if {|key, value| unneeded_attr.include?(key)}
  end
end
