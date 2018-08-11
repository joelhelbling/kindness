require 'ostruct'

RSpec.describe Kindness::Identity do
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
    Then { subject.kind_of? Kindness::Criterion }
    Then { subject.is_a? Kindness::Criterion }
  end

  describe '#essence' do
    Then { subject.essence == essence }
    Then { subject.value == essence }
    Then { subject.kind_of? OpenStruct }
    Then { subject.is_a? OpenStruct }
  end

  describe 'do not delegate' do
    Then { subject.essence.name == 'Mel' }
    Then { expect{subject.name}.to raise_error(NoMethodError) }
  end
end


