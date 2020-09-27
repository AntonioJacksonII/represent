class RepresentativesController < ApplicationController
  caches_action :index
  def index
    @members = HouseMember.by_state(params[:state_abbreviation])
    @senators = Senator.by_state(params[:state_abbreviation])
    @state = ::States[params[:state_abbreviation]]
  end
end
