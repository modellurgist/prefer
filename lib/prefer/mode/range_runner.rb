
require 'lib/prefer/io/report_file_writer'
require 'lib/prefer/io/report_string_writer'
require 'lib/prefer/simulation/simulation_specification'
require 'lib/prefer/simulation/simulation_coordinator'

class RangeRunner

  attr_reader :simulation_coordinators

  def initialize
    @simulation_coordinators = Array.new
  end

  def run(alternatives_reader, specifications_reader, export_on = false)
    # collect alternatives
    alternative_specifications = alternatives_reader.specifications
    alternatives = alternative_specifications.collect {|row| row[:alternatives]}
    # collect sets of specifications
    specification_sets = specifications_reader.specifications
    # Run all
    run_with_imported_parameters(alternatives, specification_sets, export_on)
  end
 
  def run_with_imported_parameters(alternatives, specification_sets, export_on)
    # iterate over each specification set, running one simulation for each 
    specification_sets.each do |row|
      specifications = row.to_hash
      specifications[:alternatives] = alternatives
      single_run_with_hash_parameters(specifications, export_on)
    end
  end

  def single_run_with_hash_parameters(specifications, export_on = false)
    simulation_coordinator = build_simulation_coordinator(specifications)
    run_simulation_for_each_specified_sample_size(simulation_coordinator)
    @simulation_coordinators << simulation_coordinator
    if (export_on)
      export_report(simulation_coordinator)
    end
    build_report_string(simulation_coordinator)
  end

  # private  
  
  def build_simulation_coordinator(specifications)
    simulation_specification = SimulationSpecification.new(specifications) 
    SimulationCoordinator.new(simulation_specification)
  end

  def run_simulation_for_each_specified_sample_size(simulation_coordinator)
    simulation_coordinator.run
  end

  def export_report(simulation_coordinator)
    report_file_writer = ReportWriter.new(simulation_coordinator)
    report_file_writer.report_all_sample_results
    report_file_writer.close
  end

  def build_report_string(simulation_coordinator)
    report_string_writer = ReportStringWriter.new(simulation_coordinator)
    report_string_writer.report_all_sample_results
    report_string_writer.report_string
  end

end
