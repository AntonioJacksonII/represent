class ComparisonsController < ApplicationController

  def index
    @bill = Bill.where(bill_id: "hr6395-116").first
  end

end
