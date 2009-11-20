
require 'lib/io/report_writer'

class RangeRunner

  def run(alternatives_reader, specifications_reader, export_on = false)
    # collect alternatives
    alternative_specifications = alternatives_reader.specifications
    alternatives = alternative_specifications.collect {|row| row[:alternatives]}
    # collect sets of specifications
    specification_sets = specifications_reader.specifications

    # iterate over each specification set, running one simulation for each 
    specification_sets.each do |row|
      specifications = row.to_hash
      specifications[:alternatives] = alternatives
      simulation_coordinator = build_simulation_coordinator(specifications)
      run_simulation_for_each_specified_sample_size(simulation_coordinator)
      if (export_on)
        export_report(simulation_coordinator)
      end
    end
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
    report_writer = ReportWriter.new(simulation_coordinator)
    report_writer.report_all_sample_results
    report_writer.close
  end

end
