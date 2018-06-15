module Kindness
  class Rubric
    attr_reader :criteria

    def initialize(criteria)
      @criteria = criteria
    end

    def validates?(*args)
      return false unless args.size <= criteria.size
      evaluations_for(args).all?(&:valid?)
    end

    private

    def evaluations_for(args)
      criteria.values.map do |criterion|
        criterion[args.shift]
      end
    end
  end
end
