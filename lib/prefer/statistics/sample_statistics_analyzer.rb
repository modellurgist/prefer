
class SampleStatisticsAnalyzer

  def initialize
    @t_table_map = {1=>31.82, 2=>6.96, 3=>4.54, 4=>3.75, 5=>3.36, 6=>3.14, 7=>3.00, 8=>2.90, 9=>2.82, 10=>2.76,
                   11=>2.72, 12=>2.68, 13=>2.65, 14=>2.62, 15=>2.60, 16=>2.58, 17=>2.57, 18=>2.55, 19=>2.54,
                   20=>2.53, 21=>2.52, 22=>2.51, 23=>2.50, 24=>2.49, 25=>2.48, 26=>2.48, 27=>2.47, 28=>2.47,
                   29=>2.46, 30=>2.46}
  end

  def sample_variance_given_population_mean(sample, population_mean) # assumes population mean is known
    sum(squared_deviations(sample, population_mean)) / (sample.size - 1)
  end

  def sample_mean(sample_values)
    sum(sample_values) / (sample_values.size)
  end

  def lower_confidence_limit(sample_values, population_mean)
    sample_mean(sample_values) - half_confidence_interval(sample_values, population_mean)
  end

  def upper_confidence_limit(sample_values, population_mean)
    sample_mean(sample_values) + half_confidence_interval(sample_values, population_mean)
  end

  def confidence_interval_width(sample_values, population_mean)
    2 * half_confidence_interval(sample_values, population_mean)
  end

  def standard_deviation(variance)
    Math.sqrt(variance)
  end

  def half_confidence_interval(sample_values, population_mean)
    standard_deviation = standard_deviation(sample_variance_given_population_mean(sample_values, population_mean))
    sample_size = sample_values.size
    confidence_level = 0.99
    (standard_deviation * tz_statistic(confidence_level, sample_size)) / Math.sqrt(sample_size)
  end

  # private

  def tz_statistic(confidence_level, sample_size)
    degrees_of_freedom = sample_size - 1
    if (sample_size > 30)
      if (sample_size <=40) then return 2.44
      elsif (sample_size <=60) then return 2.40
      elsif (sample_size <=120) then return 2.37
      else return 2.34
      end
    else
      return @t_table_map[degrees_of_freedom]
    end
  end

  def sum(numbers)
    numbers.inject {|sum,number| sum + number}
  end

  def squares_for_collection(values)
    values.collect {|value| value**2}
  end

  def squared_deviations(sampled_values, population_mean)
    sampled_values.collect {|value| (value - population_mean)**2}
  end

end
