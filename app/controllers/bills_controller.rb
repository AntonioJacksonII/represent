class BillsController < ApplicationController
  layout "bills_layout"
  def index
    @subjects = Bill.topics
    @name = params[:name]
    @congress_id = params[:congress_id]
  end
end
