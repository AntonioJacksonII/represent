class HouseMembersController < ApplicationController

  def show
    id = house_member_params[:id]
    @rep = HouseMember.find(id)
  end

  private

  def house_member_params
    params.permit(:id)
  end
end
