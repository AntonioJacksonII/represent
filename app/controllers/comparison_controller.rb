class ComparisonController < ApplicationController

  def index
    bill_id = params[:bill]
    selected_subject = params[:topic]
    congress_id = params[:id]
    @rep = HouseMember.where(congress_id: congress_id).first || Senator.where(congress_id: congress_id).first
    bill = Bill.where(bill_id: bill_id).first
    all_bills = Bill.where(primary_subject: selected_subject)
    
    if bill
      if @rep.class == HouseMember
        @bill = bill if bill.house_bill_vote
      elsif @rep.class == Senator 
        @bill = bill if bill.senate_bill_vote
      else 
        flash[:failure] = "This bill was not voted on by #{@rep.full_name}"
        redirect_to bills_path
      end 
    elsif all_bills
      if @rep.class == HouseMember
        @bills = all_bills.find_all do |bill|
          bill.house_bill_vote
        end
      else 
        @bills = all_bills.find_all do |bill|
          bill.senate_bill_vote
        end
      end 
    end 
  end

  private

  def comparison_params
    params.permit(:bill, :topic, :id)
  end
end
