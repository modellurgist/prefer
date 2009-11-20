
require 'lib/prefer/simulation/simulation_result_record'
require 'lib/prefer/citizen/citizen_factory'
require 'lib/prefer/citizen/citizen_repository'
require 'lib/prefer/voting/election_coordinator'
require 'lib/prefer/simulation/simulation_analyzer'

class SimulationCoordinator

  attr_reader :citizens, :results, :specification

  def initialize(specification)
    @specification = specification
    @citizen_factory = CitizenFactory.new(@specification.alternatives) 
    @citizens = Array.new 
    @results = Hash.new
    @citizen_repository = CitizenRepository.new
  end

  def run
    create_citizens
    store_citizens
    run_one_simulation_for_each_sample
  end

  def perform_sample_comparisons 
    @analyzer = SimulationAnalyzer.new(@results)
    @analyzer.perform_sample_comparisons  
  end

  def export_one_analysis_to_csv(analysis_symbol, alternative)
    string = String.new
    @results.each do |sample_size,record| 
      string << record.comparison_to_csv(analysis_symbol, alternative)
    end
    string
  end

  #private

  def create_citizens
    for index in 1..@specification.population_size  
      @citizens << @citizen_factory.build
    end
  end

  def store_citizens
    @citizens.each do |citizen|
      @citizen_repository.store(citizen)
    end
  end

  def increment_size 
    @specification.sample_size_increment
  end

  def select_sample(sample_size)
    @citizen_repository.sample(sample_size)
  end

  def run_one_simulation_for_each_sample
    increment_size.step(@specification.population_size, increment_size) do |sample_size|
      citizen_sample = select_sample(sample_size)
      run_one_simulation(citizen_sample, sample_size)
    end
  end

  def run_one_simulation(citizen_sample, sample_size)
    election_coordinator = ElectionCoordinator.new(citizen_sample, @specification.voting_method)
    store_simulation_result(election_coordinator, sample_size)
  end

  def store_simulation_result(election_coordinator, sample_size)
    record = SimulationResultRecord.new
    record.specifications = @specification.specifications
    election_coordinator.report_election(record)
    election_coordinator.report_analysis(record)
    @results[sample_size] = record 
  end

  def collected_profiles
    profiles = Array.new 
    @citizens.each do |citizen| 
      profiles << citizen.profile
    end
  end

end

