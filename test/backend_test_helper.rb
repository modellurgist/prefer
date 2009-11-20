
require 'rubygems'
require 'context'
require 'mocha'

require 'lib/require_relative'

class Test::Unit::TestCase

  
  def assert_includes_all_from(a_collection, another_collection)
    assert_block do
      another_collection.each do |item| 
        unless a_collection.include?(item)
          break false
        end
        true
      end
    end
  end

end
