
class ProbabilityMassFunctionTransient

  attr_reader :integer_probability_relation, :class_probability_relation

  def initialize
    @class_probability_relation = Array.new
    @integer_probability_relation = Array.new
  end

  def build_population_of_size(population_size)
    expanded_distribution = expand_distribution_to_correct_size(population_size)
    population = Array.new
    expanded_distribution.each do |pair|
      subcollection = population_members_of_class_from_integer_relation(pair)
      population.concat(subcollection)
    end
    population
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

  def population_members_of_class_from_integer_relation(pair)
    pair.last.times.collect { pair.first }
  end

  def expand_distribution_to_correct_size(population_size)
    distribution = @class_probability_relation.dup
    expanded_distribution = distribution.collect {|pair| [pair.first, (pair.last * population_size).round]}
    expanded_distribution = expanded_distribution.sort {|pair_a, pair_b| pair_b.last <=> pair_a.last}
    corrections = expanded_distribution.collect {|pair| 0}
    while (population_size_of_integer_relation(corrected_distribution(expanded_distribution, corrections)) != population_size) do
      if (population_size_of_integer_relation(corrected_distribution(expanded_distribution, corrections)) > population_size)
        correct_once_downward(corrections)
      else
        correct_once_upward(corrections)
      end
    end
    corrected_distribution(expanded_distribution, corrections)
  end

  def population_size_of_integer_relation(relation)
    values = relation.collect {|pair| pair.last}
    values.inject {|sum, value| sum + value}
  end

  def corrected_distribution(distribution, corrections)
    corrected_distribution = Array.new
    distribution.each_with_index do |pair, index|
      initial_value = pair.last
      adjusted_value = initial_value + corrections[index]
      corrected_distribution << [pair.first, adjusted_value]
    end
    corrected_distribution
  end

  def correct_once_downward(corrections)
    index = corrections.index(0)
    corrections[index] = -1
  end

  def correct_once_upward(corrections)
    index = corrections.index(0)
    corrections[index] = 1
  end

end
