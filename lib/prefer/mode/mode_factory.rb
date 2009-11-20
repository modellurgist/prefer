
require 'lib/prefer/mode/range_runner'

class ModeFactory

  def build_runner(mode_class_name)
    run_mode = self.class.const_get(mode_class_name)
    run_mode.new
  end

end
