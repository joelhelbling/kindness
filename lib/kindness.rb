require 'kindness/version'
require 'kindness/rubric'

module Kindness
  def self.extended(base)
    base.include Rubric
  end

  def [](essence)
    self.new.tap do |kind|
      kind.instance_variable_set(:@essence, essence)
    end
  end
end
