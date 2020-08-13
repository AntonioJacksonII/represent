class ResultsController < ApplicationController

  def show
    @rep = Senator.find_by(congress_id: params[:congress_id]) || HouseMember.find_by(congress_id: params[:congress_id])
    @comparison_score = (params[:comparison_score])
    if current_user && current_user.house_favorites.find_by(house_member_id: @rep.id)
      @aggregate_score = current_user.house_favorites.find_by(house_member_id: @rep.id).aggregate_comparison
    elsif current_user && current_user.senator_favorites.find_by(senator_id: @rep.id)
      @aggregate_score = current_user.senator_favorites.find_by(senator_id: @rep.id).aggregate_comparison
    end
    @matching_bills = find_matching_bills if params[:matching_bills]
    @not_matching_bills = find_not_matching_bills if params[:not_matching_bills]
  end

  def create
    input_congress_id = params[:congress_id]
    user_votes = results_params.select { |bill_id, vote| vote == "yes" || vote == "no" }
    if Senator.includes?(input_congress_id)
      senator = Senator.find_by(congress_id: input_congress_id)
      results = senator.compare_votes_with_user(user_votes)
      current_user.add_comparison_score(senator.id, 'senate', results) if current_user
    elsif HouseMember.includes?(input_congress_id)
      house_member = HouseMember.find_by(congress_id: input_congress_id)
      results = house_member.compare_votes_with_user(user_votes)
      current_user.add_comparison_score(house_member.id, "house", results) if current_user
    end
    redirect_to results_path(input_congress_id, results)
  end

  private

  def results_params
    params.permit!.to_h
  end

  def find_matching_bills
    matching_bills = []
    params[:matching_bills].each do |bill|
      matching_bills << Bill.find_by(short_title: bill)
    end
    matching_bills
  end

  def find_not_matching_bills
    not_matching_bills = []
    params[:not_matching_bills].each do |bill|
      not_matching_bills << Bill.find_by(short_title: bill)
    end
    not_matching_bills
  end
end
