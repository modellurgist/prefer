
class CitizenRepository

  def initialize
    @citizens = []
  end

  def store(citizen)
    @citizens << citizen
  end

  def find_by_id(object_id)
    @citizens.find { |citizen| citizen.object_id == object_id }
  end

  def sample(size)
    check_requested_size(size)
    retrieve_sample_without_duplicates(size)
  end

  # private

  def retrieve_sample_without_duplicates(size)
    sample = Array.new
    citizens_copy = Array.new(@citizens)
    size.times do 
      selected_citizen = citizens_copy[rand(citizens_copy.size)] 
      sample << selected_citizen
      citizens_copy.delete(selected_citizen) { throw :not_found }
    end
    sample
  end

  def check_requested_size(size)
    if (size > @citizens.size) then throw :sample_exceeds_population 
    end
  end

end
