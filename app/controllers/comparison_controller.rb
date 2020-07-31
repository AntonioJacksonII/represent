class ComparisonController < ApplicationController

  def index
    bill_id = params[:bill]
    selected_subject = params[:topic]
    congress_id = params[:id]
    @bills = Bill.where(primary_subject: selected_subject)
    @rep = HouseMember.where(congress_id: congress_id).first || Senator.where(congress_id: congress_id).first
    if bill_id
      @bill = Bill.where(bill_id: bill_id).first
      if @bill.nil?
        flash[:alert] = "This bill does not exist"
        redirect_to "/bills?name=#{@rep.full_name}&congress_id=#{congress_id}"
      end
    end
  end

  private

  def comparison_params
    params.permit(:bill, :topic, :id)
  end

end
