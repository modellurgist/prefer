
class VotePercentCalculation

  def symbol
    :vote_percent
  end

  def run(record)
    citizens = record.election_record[:citizen_sample]
    percentages = Hash.new 
    alternatives(citizens).each do |alternative|
      percentages[alternative] = vote_percent(alternative, citizens)
    end
    record.record_analysis(symbol, percentages)
  end

  # private
  
  def alternatives(citizens)
    citizens[0].profile
  end
  
  def vote_percent(alternative, citizens)
    1.0 * total_supporter_votes(alternative, citizens) / total_votes_cast(citizens) * 100
  end

  def total_votes_cast(citizens)
    citizens.size
  end

  def total_supporter_votes(alternative, citizens)
    first_choice_supporters = citizens.find_all { |citizen| citizen.profile.first == alternative }
    first_choice_supporters.size 
  end

end
