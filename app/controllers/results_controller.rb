class ResultsController < ApplicationController

  def show
    @rep = Senator.find_by(congress_id: params[:congress_id]) || HouseMember.find_by(congress_id: params[:congress_id])
    @comparison_score = (params[:comparison_score])
    @matching_bills = params[:matching_bills]
    @not_matching_bills = params[:not_matching_bills]
  end

  def create
    yes_array = []
    no_array = []
    
    results_params.map do |key, value|
      if value == "yes"
        yes_array << key
      elsif value == "no"
        no_array << key
      end 
    end 

    if Senator.includes?(params[:congress_id])
      senator = Senator.find_by(congress_id: params[:congress_id])

      yes_roll_calls = {}
      yes_array.each do |bill_id|
        yes_roll_calls[Bill.find_by(bill_id: bill_id).senate_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).senate_bill_vote.offset
      end 

      no_roll_calls = {}
      no_array.each do |bill_id|
        no_roll_calls[Bill.find_by(bill_id: bill_id).senate_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).senate_bill_vote.offset
      end
      
      yes_hash = {}
      yes_roll_calls.each do |roll_call, offset|
        yes_hash["#{roll_call}"] = SinatraService.new.get_member_votes(results_params[:congress_id], offset)["data"]["#{roll_call}"]
      end 

      no_hash = {}
      no_roll_calls.each do |roll_call, offset|
        no_hash["#{roll_call}"] = SinatraService.new.get_member_votes(results_params[:congress_id], offset)["data"]["#{roll_call}"]
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
      
      redirect_to results_path(params[:congress_id], comparison_score: comparison_score, matching_bills: matching_bills, not_matching_bills: not_matching_bills)

    elsif HouseMember.includes?(params[:congress_id])
      house_member = HouseMember.find_by(congress_id: params[:congress_id])
      yes_roll_calls = {}
      yes_array.each do |bill_id|
        yes_roll_calls[Bill.find_by(bill_id: bill_id).house_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).house_bill_vote.offset
      end 

      no_roll_calls = {}
      no_array.each do |bill_id|
        no_roll_calls[Bill.find_by(bill_id: bill_id).house_bill_vote.roll_call] = Bill.find_by(bill_id: bill_id).house_bill_vote.offset
      end
      
      yes_hash = {}
      yes_roll_calls.each do |roll_call, offset|
        yes_hash["#{roll_call}"] = SinatraService.new.get_member_votes(results_params[:congress_id], offset)["data"]["#{roll_call}"]
      end 

      no_hash = {}
      no_roll_calls.each do |roll_call, offset|
        no_hash["#{roll_call}"] = SinatraService.new.get_member_votes(results_params[:congress_id], offset)["data"]["#{roll_call}"]
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
      
      redirect_to results_path(params[:congress_id], comparison_score: comparison_score, matching_bills: matching_bills, not_matching_bills: not_matching_bills)
    else
      #flash message indicating that id is not a housemember or senator
    end 
  end 

  private

  def results_params
    params.permit!.to_h
  end 
end
