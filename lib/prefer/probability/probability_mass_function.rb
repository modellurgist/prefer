
class ProbabilityMassFunction

  attr_reader :integer_probability_map

  def initialize
    @class_probability_map = Hash.new
    @integer_probability_map = Hash.new
  end

  def classes_mapped?
    !(@class_probability_map.empty?)
  end

  def add_class_mapping(a_class, class_probability)
    @class_probability_map[a_class] = class_probability
  end

  def add_integer_mapping(integer, integer_probability)
    @integer_probability_map[integer] = integer_probability
  end

  def classes
    @class_probability_map.keys
  end

  def class_probabilities
    unless @class_probability_map.empty? then return @class_probability_map.values
    else return @integer_probability_map.values
    end
  end

  def number_unique_classes
    @class_probability_map.size
  end

  # private


end
