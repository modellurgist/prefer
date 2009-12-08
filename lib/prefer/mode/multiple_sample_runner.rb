

require 'lib/prefer/mode/common/simulation_runner'

class MultipleSampleRunner < SimulationRunner

  # called by SimulationsController
  def run_with_hash_parameters(specifications, export_on = false)
    simulation_coordinator = build_simulation_coordinator(specifications)
    simulation_coordinator.run_multiple_elections_for_one_sample_size
    post_run_tasks(simulation_coordinator, export_on)
  end


  # private


end
