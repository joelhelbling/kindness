require 'ostruct'

module Kindness
  module Rubric
    attr_reader :messages

    def valid?
      @messages = {}
      return true if rubrics.nil?
      rubrics.each_pair do |name, rubric|
        unless rubric.rule.call(essence)
          @messages[name] = rubric.message
        end
      end

      @messages.empty?
    end

    def rubrics
      self.class.rubrics
    end
    private :rubrics

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def rubric(rule_name, message=nil, &block)
        message ||= "Invalid #{rule_name}"
        rubrics[rule_name] = OpenStruct.new({
          message: message,
          rule: block
        })
      end

      def rubrics
        @rubrics ||= {}
      end
    end
  end
end
