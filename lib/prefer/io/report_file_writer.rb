
require 'lib/prefer/io/report_writer'

class ReportFileWriter < ReportWriter

  def method_missing(name, *args)
    unless (@file)
      create_file
    end
    @file.send(name, *args) 
  end

end
