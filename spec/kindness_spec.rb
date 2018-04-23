require 'kindness'
require 'kindness/rubric'

RSpec.describe Kindness do
  class Duck
    extend Kindness
  end

  describe 'behavior' do
    Given(:essence) { :daffy }
    When(:subject) { Duck[essence] }

    Then { subject.is_a? Kindness::Rubric }
    Then { subject.essence == essence }
    Then { subject.class == Duck }

  end

  describe 'version number' do
    Then { expect(Kindness::VERSION).not_to be_nil }
  end
end
