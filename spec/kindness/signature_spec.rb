require 'ostruct'

RSpec.describe Kindness::Signature do
  Given do
    class Predator
      extend Kindness

      insist :says do |essence|
        essence.speak == 'yip'
      end
    end

    class Fowl
      extend Kindness

      insist :quacks do |essence|
        essence.speak == 'kweh'
      end
    end

    class Grain
      extend Kindness

      insist :silent do |essence|
        essence && !essence.respond_to?(:speak)
      end
    end
  end

  Given(:signature) do
    described_class.new fox: Predator, goose: Fowl, wheat: Grain
  end

  When(:parameters) do
    [
      OpenStruct.new(speak: fox_say),
      OpenStruct.new(speak: goose_say),
      wheat
    ]
  end

  context "valid parameters" do
    Given(:fox_say) { 'yip' }
    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    Then { signature.validates?(*parameters) }
  end

  context "one parameter is invalid" do
    Given(:fox_say) { 'yarp?' }

    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    Then { not signature.validates?(*parameters) }
  end

  context "not enough parameters" do
    Given(:fox_say) { 'yip' }
    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    When { parameters.pop }

    Then { not signature.validates?(*parameters) }
  end

  context "too many parameters" do
    Given(:fox_say) { 'yip' }
    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    When { parameters << :boat }

    Then { not signature.validates?(*parameters) }
  end
end
