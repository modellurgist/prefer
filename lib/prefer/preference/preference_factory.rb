
class PreferenceFactory

  def uniformly_random_permutation(alternatives)
    alternatives.sort_by {rand}
  end
  

end
