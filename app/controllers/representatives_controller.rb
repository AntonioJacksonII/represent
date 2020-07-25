class RepresentativesController < ApplicationController
  def index
    @members = HouseMember.by_state(params[:state_abbreviation])
    @senators = Senator.by_state(params[:state_abbreviation])
    @state = ::States[params[:state_abbreviation].to_sym]
  end 
end
