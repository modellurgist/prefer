
class Combination

  class << self

    def get(n, r)
      return [] unless n > 0 and r > 0
      combine(n, r)
    end

    private

    def combine(n, r, s=0, combination=[], collector=[])
      if r.zero?
        collector << combination
      else
        for i in s..(n-r)
          combine(n, r-1, i+1, combination+[i], collector)
        end
      end
      collector
    end

  end

end