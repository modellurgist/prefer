
require 'test/backend_test_helper'
require 'lib/prefer/citizen/citizen_repository'

class CitizenRepositoryTest < Test::Unit::TestCase

  context "a new empty citizen repository" do 
    setup do 
      @repository = CitizenRepository.new
    end
    context "provided with a citizen" do 
      setup do
        @citizen = Citizen.new(["apple"])
      end
      test "should store the citizen and be able to retrieve it by object_id" do
        @repository.store(@citizen) 
        assert_same @citizen, @repository.find_by_id(@citizen.object_id)
      end
    end
  end

  context "a citizen repository with four citizens" do
    setup do
      @repository = CitizenRepository.new
      factory = CitizenFactory.new(["apple","orange","banana"])
      4.times { @repository.store( factory.build ) }
    end
    context "when a sample of 2 citizens from the total population is requested" do
      setup do 
        @sample = @repository.sample(2)
      end
      test "should return a collection containing two items" do
        assert_equal 2, @sample.size
      end
      test "a citizen from the sample should have same object_id as one from repository" do
        citizen = @sample[0]
        assert_same citizen, @repository.find_by_id(citizen.object_id)
      end
    end
    test "should throw sample exceeds population when a sample of 5 citizens requested" do
      assert_throws :sample_exceeds_population do
        @repository.sample(5)
      end
    end
    test "should not include the same citizen more than once in a sample" do
      samples = Array.new
      5.times { samples << @repository.sample(4) }
      samples_without_duplicates = samples.collect {|sample| sample.uniq}
      assert samples_without_duplicates.all? {|sample| sample.size == 4}
    end
  end

  context "a citizen repository with 20 citizens" do
    setup do
      @repository = CitizenRepository.new
      20.times { @repository.store(Citizen.new([])) }
    end
    test "should most of the time select at least one different citizen in four tries" do
      citizens = Array.new
      4.times { citizens << @repository.sample(1) }
      assert (citizens.uniq.size > 1)
    end
  end


end
