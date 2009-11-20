
require 'lib/prefer/voting/voting_method_factory'

class ElectionCoordinator

  attr_reader :citizen_sample

  def initialize(citizen_sample, voting_method)
    @citizen_sample = citizen_sample
    @voting_method_factory = VotingMethodFactory.new
    @voting_method = @voting_method_factory.build(voting_method)
  end

  def report_election(record)
    record.record_election(:social_profile => aggregate_preferences,
                           :citizen_sample => citizen_sample)
  end

  def report_analysis(record)
    @voting_method.analytical_methods.each do |analytical_method|
      analytical_method.run(record) 
    end
  end

  # private
  
  def aggregate_preferences
    @voting_method.run(@citizen_sample) 
  end


end
