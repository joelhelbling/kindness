require 'kindness'
require 'kindness/rubric'

RSpec.describe Kindness do
  class Duck
    extend Kindness
  end

  describe 'behavior' do
    Then { expect(Duck).to respond_to(:[]) }
    Then { expect(Duck[:foo]).to be_instance_of(Duck) }
  end

  describe 'version number' do
    Then { expect(Kindness::VERSION).not_to be_nil }
  end
end
