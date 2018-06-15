require 'ostruct'

RSpec.describe Kindness::Rubric do
  Given do
    class Predator
      extend Kindness

      rubric :says do |essence|
        essence.speak == 'yip'
      end
    end

    class Fowl
      extend Kindness

      rubric :quacks do |essence|
        essence.speak == 'kweh'
      end
    end

    class Grain
      extend Kindness

      rubric :silent do |essence|
        !essence.respond_to?(:speak)
      end
    end
  end
  Given(:rubric) do
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

    Then { rubric.validates?(*parameters) }
  end

  context "one parameter is invalid" do
    Given(:fox_say) { 'yarp?' }

    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    Then { not rubric.validates?(*parameters) }
  end

  context "not enough parameters" do
    Given(:fox_say) { 'yip' }
    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    When { parameters.pop }

    Then { rubric.validates?(*parameters) } # nil.respond_to?(:speak)
  end

  context "too many parameters" do
    Given(:fox_say) { 'yip' }
    Given(:goose_say) { 'kweh' }
    Given(:wheat) { :dwarf_wheat }

    When { parameters << :boat }

    Then { not rubric.validates?(*parameters) }
  end
end
