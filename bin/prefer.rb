
require 'rubygems'
require 'lib/prefer/io/specification_file_reader'
require 'lib/prefer/simulation/simulation_specification'
require 'lib/prefer/simulation/simulation_coordinator'
require 'lib/prefer/mode/mode_factory'

# get arguments
arguments = ARGV

# if incorrect minimum number of parameters is not met, display usage and basic docs
if (arguments.size != 3)
  puts
  puts "-- Help on Running Prefer"
  puts
  puts "Must specify the paths to two input files:"
  puts "(1) a csv file containing a list of alternatives"
  puts "(2) a csv file that lists sets of the rest of the simulation specifications"
  puts
  puts "Example:"
  puts "$ ruby prefer.rb RangeRunner input/alternatives.csv input/specifications.csv"
  puts
else
  # attempt to open each file
  mode_class_name = arguments[0]
  alternatives_file = File.open(arguments[1], "r")
  specifications_file = File.open(arguments[2], "r")

  # open a reader for each file
  alternatives_reader = SpecificationFileReader.new(alternatives_file)
  specifications_reader = SpecificationFileReader.new(specifications_file)

  # run all simulations and analyses, according to specifications
  EXPORT_ON = true
  mode_factory = ModeFactory.new
  runner = mode_factory.build_runner(mode_class_name)
  runner.run(alternatives_reader, specifications_reader, EXPORT_ON)
  
  # cleanup tasks before exiting
  alternatives_file.close
  specifications_file.close 

end
