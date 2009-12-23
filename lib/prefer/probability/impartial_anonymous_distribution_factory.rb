
require 'lib/prefer/probability/distribution_factory'

class ImpartialAnonymousDistributionFactory < DistributionFactory


  # private

  def build_function_with_integer_probability_mappings(alternatives)
    #integer_distribution = hardcoded_integer_distribution
    integer_distribution = build_unnormalized_distribution(alternatives)
    @probability_function_generator.build_from_integers(integer_distribution)
  end

  def hardcoded_integer_distribution
    # number of entries is number of permutations of alternatives  |A|!
    # 3 alternatives: [ , , , , , ]
    # 4 alternatives: [ , , , , , , , , , , , , , , , , , , , , , , , ]
    #[
    #[ 1, 0, 0, 0, 0, 0 ],
    #[ 1, 1, 0, 0, 0, 0 ],
    #[ 1, 1, 1, 0, 0, 0 ],
    #[ 1, 1, 1, 1, 0, 0 ],
    #[ 1, 1, 1, 1, 1, 0 ],
    #[ 1, 1, 1, 1, 1, 1 ],
    #[ 2, 1, 0, 0, 0, 0 ]
    #[ 50, 5, 1, 1, 0, 0 ]
    [ 20, 10, 3, 1, 0, 0 ]
    #[ 20, 18, 10, 7, 2, 1 ]
    #[ 20, 20, 20, 4, 3, 0 ]
    #[ 100, 70, 20, 13, 5, 2 ]
    #[ 70, 60, 40, 8, 3, 3 ]
    # try some IAC-1 distributions next
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #[ 1, 1, 1, 1, 1, 1 ]
    #]
  end
  
  def build_unnormalized_distribution(alternatives)
    number_of_permutations_of(alternatives).times.collect do
      random_integer = @random_service.select_integer_from_zero_to_one_less_than(10000)
      random_integer
    end
  end

end
