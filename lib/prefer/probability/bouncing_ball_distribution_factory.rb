
require 'lib/prefer/probability/distribution_factory'

class BouncingBallDistributionFactory < DistributionFactory


  # private

  def build_unnormalized_distribution(alternatives)
    maximum_integer = 10000
    number_of_permutations_of(alternatives).times.collect do
      random_integer = @random_service.select_integer_from_zero_to_one_less_than(maximum_integer)
      if (random_integer > 0) then maximum_integer = random_integer
      else maximum_integer = 1
      end
      random_integer
    end
  end

end
