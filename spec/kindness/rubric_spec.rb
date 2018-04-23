require 'kindness'
require 'kindness/rubric'
require 'ostruct'

RSpec.describe Kindness::Rubric do
  Given do
    class Director
      extend Kindness
    end
  end

  Given(:essence) { OpenStruct.new name: 'Mel', age: 43 }
  When(:subject) { Director[essence] }

  describe 'class' do
    Then { subject.class == Director }

    Then { subject.kind_of? Director }
    Then { subject.is_a? Director }
    Then { subject.kind_of? Kindness::Rubric }
    Then { subject.is_a? Kindness::Rubric }
  end

  describe '#essence' do
    Then { subject.essence == essence }

    Then { subject.kind_of? OpenStruct }
    Then { subject.is_a? OpenStruct }
  end

  describe 'delegation' do
    context 'getting' do
      Then { subject.name == 'Mel' }
    end

    context 'mutation' do
      When { subject.name = 'Mr. Gibson' }
      Then { essence.name == 'Mr. Gibson' }
    end
  end

  describe '#valid?' do
    context 'overridden' do
      class Director
        def valid?
          essence.age > 50
        end
      end

      Then { expect(subject).to_not be_valid }
    end
  end
end
