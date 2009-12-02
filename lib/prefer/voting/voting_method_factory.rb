
require 'lib/prefer/voting/plurality_method'
require 'lib/prefer/voting/irv_method'

class VotingMethodFactory

  def build(requested_method)
    class_name = "#{requested_method.to_s.capitalize}Method" 
    method_class = self.class.const_get(class_name)
    method_class.new
  end

  # private


end
