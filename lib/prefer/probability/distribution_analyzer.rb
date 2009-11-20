
class DistributionAnalyzer


  def entropy(distribution)
    sum = 0.0
    distribution.class_probabilities.each do |class_probability|
      sum = sum + class_probability * self_information(class_probability) 
    end
    sum
  end

  # private
 
  def self_information(class_probability) 
    log_base_2(inverse(class_probability))
  end

  def inverse(number)
    1.0/number
  end

  def log_base_2(number)
    Math.log10(number) / Math.log10(2)
  end

end
