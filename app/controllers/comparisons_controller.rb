class ComparisonsController < ApplicationController

  def index
    bill_id = params[:bill]
    @bill = Bill.where(bill_id: bill_id).first
  end

end
