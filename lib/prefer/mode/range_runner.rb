
require 'lib/prefer/mode/common/simulation_runner'

class RangeRunner < SimulationRunner

  # called by command-line tool (deprecated)
  def run(alternatives_reader, specifications_reader, export_on = false)
    import_specifications(alternatives_reader, specifications_reader)
    # Run all
    run_with_imported_parameters(@alternatives, @specification_sets, export_on)
  end

  # called by SimulationsController
  def run_with_hash_parameters(specifications, export_on = false)
    simulation_coordinator = build_simulation_coordinator(specifications)
    simulation_coordinator.run_one_election_for_each_in_sample_size_range
    post_run_tasks(simulation_coordinator, export_on)
  end


  # private  


  # deprecated

  def import_specifications(alternatives_reader, specifications_reader)
    # collect alternatives
    alternative_specifications = alternatives_reader.specifications
    @alternatives = alternative_specifications.collect {|row| row[:alternatives]}
    # collect sets of specifications
    @specification_sets = specifications_reader.specifications
  end

  def run_with_imported_parameters(alternatives, specification_sets, export_on)
    # iterate over each specification set, running one simulation for each
    specification_sets.each do |row|
      specifications = row.to_hash
      specifications[:alternatives] = alternatives
      single_run_with_hash_parameters(specifications, export_on)
    end
  end

end
