class SenatorsController < ApplicationController
  def show
    id = senator_params[:id]
    @senator = Senator.find(id)
  end

  private

  def senator_params
    params.permit(:id)
  end
end
