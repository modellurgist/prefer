
class ProbabilityDistribution

  def initialize_with_population(population)
    @population = population
    @distribution = build_distribution
  end

  def class_probabilities
    @distribution.values
  end

  def number_unique_classes
    identify_unique_classes.size
  end

  # private

  def build_distribution
    distribution = Hash.new
    population_size = @population.size
    identify_unique_classes.each do |a_class|
      distribution[a_class] = class_members(a_class).size * 1.0 / population_size 
    end
    distribution
  end

  def identify_unique_classes
    @population.uniq
  end

  def class_members(a_class) 
    @population.find_all {|member| member == a_class} 
  end


end
