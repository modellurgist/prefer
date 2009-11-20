
require 'test/test_helper'
require 'lib/prefer/io/specification_file_reader'

class SpecificationFileReaderTest < Test::Unit::TestCase

  context "an instance is made from a simple string that specifies one simulation except its alternatives" do 
    setup do 
      file_text = <<TEXT
sample size increment,population size,voting method
5,100,plurality
TEXT
      @file_reader = SpecificationFileReader.new(file_text) 
    end
    context "the first specification returned" do
      setup do
        specifications = @file_reader.specifications 
        @first_data_row = specifications[0]
      end
      test "should return the population size" do
        assert_equal 100, @first_data_row[:population_size]
      end
      test "should return the size increment" do
        assert_equal 5, @first_data_row[:sample_size_increment]
      end
      test "should return the voting method" do
        assert_equal "plurality", @first_data_row[:voting_method]
      end
    end
  end

  context "an instance is made from a simple string that specifies one simulation's alternatives" do 
    setup do 
      file_text = <<TEXT
alternative
Gore
Nader
Bush
TEXT
      @file_reader = SpecificationFileReader.new(file_text) 
    end
    context "the collection of specifications returned is used to populate an array of simple strings" do
      setup do
        specifications = @file_reader.specifications 
        @alternatives = Array.new
        specifications.each {|specification| @alternatives << specification[:alternative]}
      end
      test "should return 3 alternatives" do
        assert_equal 3, @alternatives.size
      end
      test "should return array containing all alternatives in provided file" do
        assert_equal ["Gore","Nader","Bush"], @alternatives
      end
    end
  end


end
