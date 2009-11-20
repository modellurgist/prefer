
require 'fastercsv'

class SimulationResultRecord

  attr_reader :election_record
  attr_reader :analysis_records
  attr_reader :comparison_records
  attr_accessor :specifications

  def initialize
    @election_record = Hash.new
    @analysis_records = Hash.new
    @comparison_records = Hash.new
  end

  def winning_alternative
    @election_record[:social_profile][0]
  end

  def record_election(record_hash)
    @election_record = record_hash
  end

  def record_analysis(analysis_symbol, analysis_hash)
    @analysis_records[analysis_symbol] = analysis_hash
  end

  def record_comparison(analysis_symbol, alternative, sample_deviation)
    create_comparison_analysis_record(analysis_symbol)
    @comparison_records[analysis_symbol][alternative] = sample_deviation
  end

  def comparison_to_csv(analysis_symbol, alternative)
    to_csv_line(@comparison_records[analysis_symbol][alternative]) 
  end

  def available_comparisons
    @analysis_records.keys 
  end

  # private
 
  # TO-DO: test this.  
  def to_csv_line(record_item)
    FasterCSV.generate {|csv| csv << [sample_size, record_item]} 
  end
  
  def create_comparison_analysis_record(analysis_symbol)
    @comparison_records[analysis_symbol] = {} if @comparison_records[analysis_symbol].nil?
  end

  def sample_size
    @election_record[:citizen_sample].size
  end


end
