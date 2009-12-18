
require 'lib/prefer/statistics/sample_statistics_analyzer'
require 'lib/prefer/voting/pairwise_method'

class DistributionAnalyzer

  def initialize
    @statistician = SampleStatisticsAnalyzer.new
  end

  def entropy(distribution)
    sum = 0.0
    distribution.class_probabilities.each do |class_probability|
      sum = sum + class_probability * self_information(class_probability) 
    end
    sum
  end

  def euclidean_normal_of_pairwise_election_vector(function)
    euclidean_normal(normalized_pairwise_election_vector_coordinates(function))
  end

  # private

  def normalized_pairwise_election_vector_coordinates(function)
    @pairwise_method = PairwiseMethod.new
    @pairwise_method.pair_results_for_function(function)
  end

  def euclidean_normal(vector_coordinates)
    Math.sqrt(@statistician.sum(@statistician.squares_for_collection(vector_coordinates)))
  end
 
  def self_information(class_probability) 
    log_base_2(inverse(class_probability))
  end

  def inverse(number)
    1.0/number
  end

  def log_base_2(number)
    Math.log10(number) / Math.log10(2)
  end

end
