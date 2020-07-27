class ObjectCreator

  def create_members
    reps = service.get_representatives
    reps[:data].map do |member_info|
      HouseMember.create(member_info)
    end
  end

  def create_senators
    sens = service.get_senators
    sens[:data].map do |sen_info|
      Senator.create(sen_info)
    end
  end

  def service
    RequestService.new
  end 
end 
