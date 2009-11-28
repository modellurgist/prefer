
require 'lib/prefer/io/report_writer'

class ReportStringWriter < ReportWriter

  attr_reader :report_string

  def initialize(simulation_coordinator)
    @report_string = String.new
    super
  end

  def method_missing(name, *args)
    string_item = prepare_string_item(args)
    if (name == :puts)
      @report_string.concat(string_item) 
    end
  end

  # private
  
  def prepare_string_item(args)
    if (args.empty?) then return "<br />"
    else
      #return "<p>#{args.first}</p>"
      return "#{args.first}<br />"
    end
  end

end
