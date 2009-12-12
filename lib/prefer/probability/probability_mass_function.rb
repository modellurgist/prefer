
class ProbabilityMassFunction

  attr_reader :integer_probability_relation

  def initialize
    @class_probability_relation = Array.new
    @integer_probability_relation = Array.new
  end

  def probability_for_class(a_class)
    pair = @class_probability_relation.assoc(a_class)
    pair.last
  end

  def probability_for_integer(integer)
    pair = @integer_probability_relation.assoc(integer)
    pair.last
  end

  def classes_mapped?
    !(@class_probability_relation.empty?)
  end

  def finish_mapping_all_classes(class_integer_relation)
    class_integer_relation.each do |class_integer_pair|
      a_class = class_integer_pair.first
      integer = class_integer_pair.last
      integer_probability_relation = @integer_probability_relation.dup
      matching_integer_probability_pair = integer_probability_relation.assoc(integer)
      index_of_match = integer_probability_relation.index(matching_integer_probability_pair)
      class_probability_pair = [a_class, matching_integer_probability_pair.last]
      integer_probability_relation.delete_at(index_of_match)
      @class_probability_relation << class_probability_pair
    end
  end

  def add_class_mapping(a_class, class_probability)
    @class_probability_relation << [a_class, class_probability]
  end

  def add_integer_mapping(integer, integer_probability)
    @integer_probability_relation << [integer, integer_probability]
  end

  def classes
    @class_probability_relation.collect {|pair| pair.first}
  end

  def class_probabilities
    unless @class_probability_relation.empty? then return @class_probability_relation.collect {|pair| pair.last}
    else return integer_probabilities
    end
  end

  def integer_probabilities
    @integer_probability_relation.collect {|pair| pair.last}
  end

  def integers
    @integer_probability_relation.collect {|pair| pair.first}
  end

  def number_unique_classes
    @class_probability_relation.size
  end

  # private


end
