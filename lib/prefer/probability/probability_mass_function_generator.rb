
require 'lib/prefer/probability/probability_mass_function'

class ProbabilityMassFunctionGenerator

  def build_from_population(population)
    @population = population
    build_probability_mass_function_from_population
  end

  def build_from_integers(integers)
    @integers = integers
    build_probability_mass_function_from_integers
  end

  # private

  def build_probability_mass_function_from_integers
    function = ProbabilityMassFunction.new
    @integers.each do |integer|
      function.add_integer_mapping(integer, integer_probability(integer))
    end
    function
  end

  def integer_probability(integer)
    1.0 * integer / integers_sum
  end

  def integers_sum
    unless @integers_sum then @integers_sum = @integers.inject {|sum, i| sum + i}
    end
    @integers_sum
  end

  def build_probability_mass_function_from_population
    function = ProbabilityMassFunction.new
    identify_unique_classes.each do |a_class|
      function.add_class_mapping(a_class, class_probability(a_class))
    end
    function
  end

  def class_probability(a_class)
    class_members(a_class).size * 1.0 / population_size
  end

  def population_size
    @population.size
  end

  def identify_unique_classes
    if @population then return @population.uniq
    end
  end

  def class_members(a_class) 
    @population.find_all {|member| member == a_class} 
  end

end
