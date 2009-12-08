
require 'lib/prefer/simulation/simulation_result_record'
require 'lib/prefer/citizen/citizen_factory'
require 'lib/prefer/citizen/citizen_repository'
require 'lib/prefer/voting/election_coordinator'
require 'lib/prefer/simulation/simulation_analyzer'
require 'lib/prefer/simulation/sample_repository'

class SimulationCoordinator

  attr_reader :citizens, :results, :specification

  def initialize(specification = nil)
    @specification = specification
    if (specification) then @citizen_factory = CitizenFactory.new(@specification.alternatives)
    end
    @citizens = Array.new 
    @results = SampleRepository.new
    @citizen_repository = CitizenRepository.new
  end

  # this method only used until affected tests use method it delegates to
  #def run
  #  run_one_election_for_each_in_sample_size_range
  #end

  def run_one_election_for_each_in_sample_size_range
    pre_simulation_tasks
    increment_size.step((@specification.population_size - 1), increment_size) do |sample_size|
      run_one_sample_election(sample_size)
    end
    run_population_election(@specification.population_size)
    post_simulation_tasks
  end

  def run_multiple_elections_for_one_sample_size
    pre_simulation_tasks
    sample_size = @specification.sample_size
    repetitions = @specification.repetitions
    run_multiple_elections(sample_size, repetitions)
    post_simulation_tasks
  end

  def run_one_election_with_new_sample(sample_size)
    pre_simulation_tasks
    run_one_sample_election(sample_size)
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

  def run_one_sample_election(sample_size)
    election_coordinator = run_one_election(sample_size)
    post_sample_election_tasks(election_coordinator, sample_size)
  end

  def run_one_election(sample_size)
    citizen_sample = select_sample(sample_size)
    ElectionCoordinator.new(citizen_sample, @specification.voting_method)
  end

  def run_population_election(population_size)
    election_coordinator = run_one_election(population_size)
    post_population_election_tasks(election_coordinator, population_size)
  end

  def run_multiple_elections(sample_size, repetitions)
    repetitions.times do
      run_one_election(sample_size)
    end
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

  def post_sample_election_tasks(election_coordinator, sample_size)
    store_sample_election_result(election_coordinator, sample_size)
  end

  def post_population_election_tasks(election_coordinator, population_size)
    record = build_record(election_coordinator, population_size)
    add_to_results_for_population_size(record)
  end

  def perform_simulation_analyses
    @analyzer = SimulationAnalyzer.new(@results)
    @analyzer.perform_simulation_analyses
  end

  def store_sample_election_result(election_coordinator, sample_size)
    record = build_record(election_coordinator, sample_size)
    add_to_results_for_sample_size(record, sample_size)
  end

  def add_to_results_for_sample_size(election_record, sample_size)
    @results.store_repetition_for_size(election_record, sample_size)
  end

  def add_to_results_for_population_size(record)
    @results.store_population_record(record)
  end

  def build_record(election_coordinator, sample_size)
    record = SimulationResultRecord.new
    record.specifications = @specification.specifications
    election_coordinator.report_election(record)
    election_coordinator.report_analysis(record)
    record
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

