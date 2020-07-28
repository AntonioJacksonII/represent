class SenatorsController < ApplicationController
  def show
    id = senator_params[:id]
    @senator = Senator.find(id)
    @other_senators = Senator.by_state(@senator.state)
    @representatives = HouseMember.by_state(@senator.state)
    @state = ::States[@senator.state]
  end

  private

  def senator_params
    params.permit(:id)
  end
end
