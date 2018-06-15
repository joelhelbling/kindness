require 'kindness/version'
require 'kindness/identity'
require 'kindness/criterion'
require 'kindness/rubric'

module Kindness
  def self.extended(base)
    base.include Identity
    base.include Criterion
  end

  def [](essence)
    self.new.tap do |kind|
      kind.instance_variable_set(:@essence, essence)
    end
  end
end
