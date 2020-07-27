class BillsController < ApplicationController
  def index
    @subjects = Bill.topics
  end
end
