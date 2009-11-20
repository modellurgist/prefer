
require 'lib/prefer/voting/voting_method'

class PluralityMethod < VotingMethod

  def run(citizens)
    tallies = initialize_tally_for_each_alternative(citizens)
    citizens.each do |citizen| 
      increment_tally_for_citizen_first_choice(tallies, citizen)
    end
    determine_social_profile_by_plurality(tallies)
  end

  # private 

  def compatible_analyses
    [:vote_percent]
  end

  def initialize_tally_for_each_alternative(citizens)
    alternatives = citizens.first.profile 
    tallies = Hash.new
    alternatives.each {|alternative| tallies[alternative] = 0}
    tallies
  end

  def increment_tally_for_citizen_first_choice(tallies, citizen)
      first_choice = citizen.first_choice
      tallies[first_choice] = tallies[first_choice] + 1
  end

  def highest_tally_value(tallies)
    tallies.values.max # assume no ties for now
  end

  def determine_social_profile_by_plurality(tallies)
    [fetch_alternative_with_highest_tally(tallies)]
  end

  def fetch_alternative_with_highest_tally(tallies)
    tallies.invert.fetch(highest_tally_value(tallies))
  end

end
