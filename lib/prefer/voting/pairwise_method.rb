
require 'lib/prefer/voting/voting_method'
require 'lib/prefer/statistics/combination'

class PairwiseMethod < VotingMethod

  def initialize
    @statistician = SampleStatisticsAnalyzer.new
  end

  # define standard order as order in class probability relation?
  def pair_results_for_function(function)
    pair_results = pair_results_for_all_ballots(function)
    ballot_summations(pair_results)
  end

  # private

  def ballot_summations(pair_results)
    a_result = pair_results.first
    number_terms = a_result.size
    term_components = (0..(number_terms-1)).collect do |index|
      pair_results.collect {|pair_result| pair_result[index]}
    end
    term_components.collect do |term_set|
      @statistician.sum(term_set)
    end
  end

  def pair_results_for_all_ballots(function)
    define_pair_combinations(function)
    function.class_probability_relation.collect do |pair|
      pair_results_for_one_ballot(pair)
    end
  end

  def define_pair_combinations(function)
    classes = function.classes
    number_classes = classes.length
    number_alternatives = function.number_of_alternatives
    index_pair_combinations = Combination.get(number_alternatives, 2)
    reference_class = function.first_class
    @pair_combinations = index_pair_combinations.collect do |index_pair|
      [reference_class[index_pair.first], reference_class[index_pair.last]]
    end
  end

  def pair_results_for_one_ballot(class_probability_element)
    @pair_combinations.collect do |pair_for_comparison|
      weighted_score(class_probability_element, pair_for_comparison)
    end
  end
  
  def weighted_score(class_probability_element, pair_for_comparison)
    if (first_in_pair_is_winner(class_probability_element, pair_for_comparison))
      return class_probability_element.last
    else 
      return -(class_probability_element.last)
    end
  end

  def first_in_pair_is_winner(class_probability_element, pair_for_comparison)
    ballot = class_probability_element.first
    position_of_first = ballot.index(pair_for_comparison.first)
    position_of_second = ballot.index(pair_for_comparison.last)
    if (position_of_first < position_of_second) then return true
    else return false
    end
  end


end
