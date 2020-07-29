class ResultsController < ApplicationController

  def show
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
      #lookup senate bill vote
    elsif 
      HouseMember.includes?(params[:congress_id])
      yes_roll_calls = []
      yes_array.each do |bill_id|
        yes_roll_calls << Bill.find_by(bill_id: bill_id).house_bill_vote.roll_call
      end 
      binding.pry
      #lookup house bill vote
      Bill.find_by(bill_id: yes_array)
    else
      #flash message indicating that id is not a housemember or senator
    end 
  end 

  private

  def results_params
    params.permit!.to_h
  end 
end
