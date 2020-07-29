class ComparisonController < ApplicationController

  def index
    bill_id = params[:bill]
    selected_subject = params[:topic]
    congress_id = params[:id]
    @bill = Bill.where(bill_id: bill_id).first
    @bills = Bill.where(primary_subject: selected_subject)
    @rep = HouseMember.where(congress_id: congress_id).first || Senator.where(congress_id: congress_id).first
  end

  private

  def comparison_params
    params.permit(:bill, :topic, :id)
  end

end
