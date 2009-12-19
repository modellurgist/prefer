
require 'generator'

class ReportWriter

  def initialize(simulation_coordinator)
    @simulation_coordinator = simulation_coordinator
    @specification = @simulation_coordinator.specification
  end

  def method_missing(name, *args)
    # define in subclass
  end

  def report_all_sample_results
    write_header
    report_specification
    report_probability_function
    report_analyses
    #report_elections
  end

  # private 

  def results
    @simulation_coordinator.results
  end

  def results_iterator
    repetitions_hash = results.generate_hash_of_collected_repetitions_by_sample_size
    sorted_results = repetitions_hash.sort
    sorted_sizes = sorted_results.collect {|pair| pair.first}
    sorted_collections = sorted_results.collect {|pair| pair.last}
    SyncEnumerator.new(sorted_sizes, sorted_collections)
  end
 
  def create_file
    @file = File.new("output/#{build_filename}", "w")
  end

  def build_filename
    number_alternatives = @specification.alternatives.size 
    voting_method = @specification.voting_method
    sample_size_increment = @specification.sample_size_increment  
    "#{voting_method}-vote__#{number_alternatives}-alternatives__#{population_size}-unconnected-citizens__uniformly-distributed-profiles__sampled-mod-#{sample_size_increment}__#{readable_timestamp}.csv"
  end

  def distribution_type
    @specification.distribution_type
  end

  def random_number_generator_name
    RandomService.random_number_generator_name
  end

  def population_size
    @specification.population_size
  end

  def readable_timestamp
    Time.now.strftime("%m-%d-%Y_%H%M")
  end

  def write_header
    self.puts "Full Report of Simulation Results, Analysis, and Input"
  end

  def triple_space
    2.times { self.puts }
  end

  def double_space
    self.puts
  end

  def report_specification
    triple_space
    self.puts "Defining Specifications"
    double_space
    self.puts nested_collection_to_csv_line(@specification.specifications.keys)
    self.puts nested_collection_to_csv_line(@specification.specifications.values)
    double_space
    self.puts "Random number generator:  #{random_number_generator_name}"
  end

  def nested_collection_to_csv_line(nested_collection)
    FasterCSV.generate do |csv| 
      csv << nested_collection.collect do |item| 
        if (item.is_a?(Array))
          cloned_item = item.clone
          collection_to_string(cloned_item)
        else
          item.to_s
        end
      end
    end
  end

  def collection_to_string(collection)
    string = "("
    collection.each {|item| string << "#{item} "}
    string = string.strip
    string << ")"
  end

  def report_probability_function
    triple_space
    self.puts "Actual Probability Mass Function/Relation (Ballot vs. Probability in Population)"
    double_space
    self.puts "Ballot, Probability"
    class_probability_relation.each do |pair|
      self.puts nested_collection_to_csv_line(pair)
    end
    double_space
    self.puts "Distribution type used to generate this function:  #{distribution_type.to_s}"
    triple_space
    self.puts "Characteristics of this Probability Distribution of Preference Orderings"
    double_space
    self.puts "entropy, #{results.entropy_of_actual_preference_distribution}, bits  (Note: entropy of uniform distribution is #{results.entropy_of_uniform_distribution})"
    self.puts "euclidean normal of pairwise election vector, #{results.euclidean_normal_of_pairwise_election_vector_for_actual_distribution}"
  end

  def class_probability_relation
    results.class_probability_relation
  end

  def write_analysis_header
    triple_space
    self.puts "Results of Analyses"
    triple_space
  end

  def population_record
    results.retrieve_population_record
  end

  def population_winner
    population_record.winning_alternative
  end

  def report_analyses
    write_analysis_header
    # START: one analysis:  vote_percent
    # The Analyzed Results
    self.puts "Vote Percent Analysis Results"
    double_space
    self.puts "Sample Size, Mean Percentage Vote for Population Winner, Variance, 99% Confidence Interval Width, Lower 99% C.I., Upper 99% C.I." # this should be obtained from the analyzer or an analysis record
    results_iterator.each do |sample_size, collection|
      # consider generalizing, by first getting any analysis record and for each in it do the following
      report_statistics_for_one_variable_for_one_sample(:vote_percent, sample_size)
    end
    report_one_analysis_record(population_record.population_size, population_record, :vote_percent, population_winner)
    # The Raw Results
    triple_space
    #self.puts "Vote Percent Raw Results"
    #double_space
    #self.puts "Sample Size, Percentage Vote for Population Winner" # this should be obtained from the analyzer or an analysis record
    #results_iterator.each do |sample_size, collection|
    #  # consider generalizing, by first getting any analysis record and for each in it do the following
    #  collection.each do |record|
    #    report_one_analysis_record(sample_size, record, :vote_percent, population_winner)
    #  end
    #end
    #report_one_analysis_record(population_record.population_size, population_record, :vote_percent, population_winner)
    # END of one analysis
  end

  # shouldn't an analysis know how to report itself, using the result record??!!
  def report_one_analysis_record(sample_size, record, analysis_symbol, alternative)
    self.puts "#{sample_size},#{record.analysis_records[analysis_symbol][alternative]}"
  end

  def report_statistics_for_one_variable_for_one_sample(calculated_variable_symbol, sample_size)
    statistics_as_csv = simple_collection_to_csv_line(statistics_for(calculated_variable_symbol, sample_size))
    self.puts "#{sample_size},#{statistics_as_csv}"
  end

  def statistics_for(calculated_variable_symbol, sample_size)
    [:mean, :variance, :confidence_interval_width, :lower_confidence_limit, :upper_confidence_limit].collect do |statistic_symbol|
      results.find_statistic_for_sample_size(sample_size, statistic_symbol, calculated_variable_symbol, population_winner)
    end
  end

  def report_elections
    results_iterator.each do |sample_size, collection|
      collection.each do |record|
        report_one_election(sample_size, record)
      end
    end
    report_one_election(population_size, population_record)
  end

  def report_one_election(sample_size, record)
    write_election_header(sample_size)
    election_record = record.election_record
    report_social_profile(election_record)
    report_citizen_profiles(election_record)
  end

  def write_election_header(sample_size)
    triple_space
    self.puts "Sample Size of #{sample_size} Citizens"
    double_space
  end

  def report_social_profile(election_record)
    double_space
    self.puts "Social Profile (left-most is highest-ranked alternative)"
    double_space
    profile = election_record[:social_profile]
    self.puts simple_collection_to_csv_line(profile)
  end
  
  def report_citizen_profiles(election_record)
    double_space
    self.puts "Profiles of Citizens in Sample (left-most is highest-ranked alternative)"
    double_space
    election_record[:ballots].each do |ballot|
      self.puts simple_collection_to_csv_line(ballot)
    end
  end

  def simple_collection_to_csv_line(collection)
    FasterCSV.generate {|csv| csv << collection}
  end

end
