
require 'lib/rubyvote/lib/rubyvote/irv'

class IrvMethod < VotingMethod

  def run(citizens)
    profiles = collect_preference_profiles(citizens) 
    determine_social_profile_by_irv(profiles)
  end

  # private 

  def compatible_sample_analyses
    [:vote_percent]
  end
  
  def compatible_simulation_analyses
    [:compare_by_vote_percent, :sample_statistics]
  end

  def determine_social_profile_by_irv(profiles)
    irv = InstantRunoffVote.new(profiles)
    irv.result.ranked_candidates
  end
  

end
