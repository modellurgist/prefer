
require 'lib/prefer/probability/probability_mass_function'

class ProbabilityMassFunctionGenerator

  def build_from_population(population)
    @population = population
    build_probability_mass_function_from_population
  end

  # private

  def build_from_integers(integers)

  end

  def build_probability_mass_function_from_population
    function = ProbabilityMassFunction.new
    identify_unique_classes.each do |a_class|
      function.add_mapping(a_class, (class_members(a_class).size * 1.0 / population_size))
    end
    function
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
