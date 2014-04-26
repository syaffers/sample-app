module Faker
  class Academic < Base
    class << self
      def rank
        fetch('academic.rank')
      end
    end
  end
end