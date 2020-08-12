class BillsController < ApplicationController
  layout "bills_layout"
  def index
    @name = params[:name]
    @congress_id = params[:congress_id]
    @representative = HouseMember.find_by(congress_id: @congress_id) || Senator.find_by(congress_id: @congress_id)
    @five_recent = Bill.find_recent_five(@representative)
    @subjects = Bill.house_topics if @representative.class == HouseMember
    @subjects = Bill.senate_topics if @representative.class == Senator
  end
end
