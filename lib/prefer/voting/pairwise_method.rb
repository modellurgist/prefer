
require 'lib/prefer/voting/voting_method'

class PairwiseMethod < VotingMethod



  # define standard order as order in class probability relation
  def pair_results_for_function(function)
    ballot_summations(pair_results_for_all_ballots(function))
  end

  # private

  def pair_results_for_all_ballots(function)
    function.
  end


end
