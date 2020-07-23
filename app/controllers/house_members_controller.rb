class HouseMembersController < ApplicationController

  def show
    id = params[:id]
    @rep = HouseMember.find(id)
  end
end
