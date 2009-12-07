
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

  # this method only used until affected tests use method it delegates to
  def run
    run_one_election_for_each_in_sample_size_range
  end

  def run_one_election_for_each_in_sample_size_range
    pre_simulation_tasks
    increment_size.step(@specification.population_size, increment_size) do |sample_size|
      run_one_election(sample_size)
    end
    post_simulation_tasks
  end

  def run_multiple_elections_for_one_sample_size
    pre_simulation_tasks
    run_multiple_elections(sample_size)
    post_simulation_tasks
  end

  def run_one_election_with_new_sample(sample_size)
    pre_simulation_tasks
    run_one_election(sample_size)
    post_simulation_tasks
  end

  #def export_one_analysis_to_csv(analysis_symbol, alternative)
  #  string = String.new
  #  @results.each do |sample_size,record|
  #    string << record.comparison_to_csv(analysis_symbol, alternative)
  #  end
  #  string
  #end


  #private

  def run_one_election(sample_size)
    citizen_sample = select_sample(sample_size)
    election_coordinator = ElectionCoordinator.new(citizen_sample, @specification.voting_method)
    post_election_tasks(election_coordinator, sample_size)
  end

  def pre_simulation_tasks
    if (@citizen_repository.empty?)
      create_citizens
      store_citizens
    end
  end

  def post_simulation_tasks
    perform_simulation_analyses
  end

  def post_election_tasks(election_coordinator, sample_size)
    store_election_result(election_coordinator, sample_size)
  end

  def perform_simulation_analyses
    @analyzer = SimulationAnalyzer.new(@results)
    @analyzer.perform_simulation_analyses
  end

  def store_election_result(election_coordinator, sample_size)
    record = SimulationResultRecord.new
    record.specifications = @specification.specifications
    election_coordinator.report_election(record)
    election_coordinator.report_analysis(record)
    @results[sample_size] = record
  end

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

  def collected_profiles
    profiles = Array.new 
    @citizens.each do |citizen| 
      profiles << citizen.profile
    end
  end

end

