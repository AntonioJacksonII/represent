class ResultsController < ApplicationController

  def show
    @rep = Senator.find_by(congress_id: params[:congress_id]) || HouseMember.find_by(congress_id: params[:congress_id])
    @comparison_score = (params[:comparison_score])
    @matching_bills = params[:matching_bills]
    @not_matching_bills = params[:not_matching_bills]
  end

  def create
    input_congress_id = params[:congress_id]
    user_yes_votes = user_votes("yes")
    user_no_votes = user_votes("no")

    if Senator.includes?(input_congress_id)
      senator = Senator.find_by(congress_id: input_congress_id)
      yes_roll_calls = {}
      user_yes_votes.each do |bill_id|
        yes_roll_calls[Bill.find_by(bill_id: bill_id).senate_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).senate_bill_vote.session
      end

      no_roll_calls = {}
      user_no_votes.each do |bill_id|
        no_roll_calls[Bill.find_by(bill_id: bill_id).senate_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).senate_bill_vote.session
      end

      yes_hash = {}
      yes_roll_calls.each do |roll_call, session|
        yes_hash["#{roll_call}"] = SinatraService.new.get_member_votes(input_congress_id, roll_call, "senate", session)["data"]["#{roll_call}"]
      end

      no_hash = {}
      no_roll_calls.each do |roll_call, session|
        no_hash["#{roll_call}"] = SinatraService.new.get_member_votes(input_congress_id, roll_call, "senate", session)["data"]["#{roll_call}"]
      end


      matching_array = []
      not_matching_array = []
      yes_hash.each do |roll_call, member_vote|
        if member_vote == "Yes"
          matching_array << roll_call
        elsif member_vote == "No"
          not_matching_array << roll_call
        end
      end

      no_hash.each do |roll_call, member_vote|
        if member_vote == "Yes"
          not_matching_array << roll_call
        elsif member_vote == "No"
          matching_array << roll_call
        end
      end

      not_matching_bills = not_matching_array.map do |roll_call_num|
        SenateBillVote.find_by(roll_call: "#{roll_call_num}").bill.short_title
      end

      matching_bills = matching_array.map do |roll_call_num|
        SenateBillVote.find_by(roll_call: "#{roll_call_num}").bill.short_title
      end

      comparison_score = (matching_array.length.to_f / (matching_array.length + not_matching_array.length).to_f) * 100

      if current_user && current_user.senator_favorites.find_by(senator_id: senator.id)
        favorite = current_user.senator_favorites.find_by(senator_id: senator.id)
        favorite.update(comparison_score: comparison_score)
        favorite.save
      end

      redirect_to results_path(input_congress_id, comparison_score: comparison_score, matching_bills: matching_bills, not_matching_bills: not_matching_bills)

    elsif HouseMember.includes?(input_congress_id)
      house_member = HouseMember.find_by(congress_id: input_congress_id)
      yes_roll_calls = {}
      user_yes_votes.each do |bill_id|
        yes_roll_calls[Bill.find_by(bill_id: bill_id).house_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).house_bill_vote.session
      end

      no_roll_calls = {}
      user_no_votes.each do |bill_id|
        no_roll_calls[Bill.find_by(bill_id: bill_id).house_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).house_bill_vote.session
      end

      yes_hash = {}
      yes_roll_calls.each do |roll_call, session|
        yes_hash["#{roll_call}"] = SinatraService.new.get_member_votes(input_congress_id, roll_call, "house", session)["data"]["#{roll_call}"]
      end

      no_hash = {}
      no_roll_calls.each do |roll_call, session|
        no_hash["#{roll_call}"] = SinatraService.new.get_member_votes(input_congress_id, roll_call, "house", session)["data"]["#{roll_call}"]
      end


      matching_array = []
      not_matching_array = []
      yes_hash.each do |roll_call, member_vote|
        if member_vote == "Yes"
          matching_array << roll_call
        elsif member_vote == "No"
          not_matching_array << roll_call
        end
      end

      no_hash.each do |roll_call, member_vote|
        if member_vote == "Yes"
          not_matching_array << roll_call
        elsif member_vote == "No"
          matching_array << roll_call
        end
      end

      not_matching_bills = not_matching_array.map do |roll_call_num|
        HouseBillVote.find_by(roll_call: "#{roll_call_num}").bill.short_title
      end

      matching_bills = matching_array.map do |roll_call_num|
        HouseBillVote.find_by(roll_call: "#{roll_call_num}").bill.short_title
      end

      comparison_score = (matching_array.length.to_f / (matching_array.length + not_matching_array.length).to_f) * 100

      if current_user && current_user.house_favorites.find_by(house_member_id: house_member.id)
        favorite = current_user.house_favorites.find_by(house_member_id: house_member.id)
        favorite.update(comparison_score: comparison_score)
        favorite.save
      end

      redirect_to results_path(input_congress_id, comparison_score: comparison_score, matching_bills: matching_bills, not_matching_bills: not_matching_bills)
    else
      #flash message indicating that id is not a housemember or senator
    end
  end

  private

  def results_params
    params.permit!.to_h
  end

  def user_votes(type)
    votes = []
    results_params.each do |bill_id, user_vote|
      if user_vote == type
        votes << bill_id
      end
    end
    votes
  end
end
