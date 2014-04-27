module Faker
  class Academic < Base
    class << self
      def rank
        fetch('academic.rank')
      end
      
      def tag
        fetch('academic.tag')
      end
    end
  end
end