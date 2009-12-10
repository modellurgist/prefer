
class ProbabilityMassFunction

  def initialize
    @distribution_map = Hash.new
  end

  def add_mapping(a_class, class_probability)
    @distribution_map[a_class] = class_probability
  end

  def classes
    @distribution_map.keys
  end

  def class_probabilities
    @distribution_map.values
  end

  def number_unique_classes
    @distribution_map.size
  end

  # private


end
