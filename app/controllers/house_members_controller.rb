class HouseMembersController < ApplicationController

  def show
    id = house_member_params[:id]
    @rep = HouseMember.find(id)
    @other_reps = HouseMember.by_state(@rep.state)
    @senators = Senator.by_state(@rep.state)
    @state = ::States[@rep.state]
  end

  private

  def house_member_params
    params.permit(:id)
  end
end
