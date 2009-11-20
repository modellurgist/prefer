
require 'fastercsv'

class SpecificationFileReader

  def initialize(source)
    if (source.is_a?(IO) || source.is_a?(String))
      @fastercsv = FasterCSV.new(source, {:headers => true, :converters => :integer, :header_converters => :symbol})
    end
  end

  def specifications
    fastercsv_table
  end

  # private

  def fastercsv_table
    unless @table
      @table = @fastercsv.read
    end
    @table.clone
  end

end
