
require 'lib/prefer/io/report_file_writer'
require 'lib/prefer/io/report_string_writer'
require 'lib/prefer/simulation/simulation_specification'
require 'lib/prefer/simulation/simulation_coordinator'

class SimulationRunner

  attr_reader :simulation_coordinators

  def initialize
    @simulation_coordinators = Array.new
  end

  # private

  def post_run_tasks(simulation_coordinator, export_on)
    store_coordinator(simulation_coordinator)
    # are the stored coordinators ever used?  is only one stored?
    export_report_if_requested(simulation_coordinator, export_on)
    build_report_string(simulation_coordinator)
  end

  def build_simulation_coordinator(specifications)
    simulation_specification = SimulationSpecification.new(specifications)
    SimulationCoordinator.new(simulation_specification)
  end

  def store_coordinator(simulation_coordinator)
    @simulation_coordinators << simulation_coordinator
  end

  def export_report_if_requested(simulation_coordinator, export_on)
    if (export_on)
      export_report(simulation_coordinator)
    end
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