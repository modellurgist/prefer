
class SampleStatisticsAnalyzer

  def initialize
  end

  def sample_variance_given_population_mean(sample, population_mean) # assumes population mean is known
    sum(squared_deviations(sample, population_mean)) / (sample.size - 1)
  end


  # private

  def sum(numbers)
    numbers.inject {|sum,number| sum + number}
  end

  def squared_deviations(sampled_values, population_mean)
    sampled_values.collect {|value| (value - population_mean)**2}
  end

end
