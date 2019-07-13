require 'ostruct'

RSpec.describe Kindness::Criterion do
  Given do
    class Dad
      extend Kindness
    end
  end

  When(:subject) { Dad[essence] }

  describe '#valid?' do
    context 'with no rules defined' do
      Given(:essence) { OpenStruct.new name: 'Homer', age: 43 }
      Then { expect(subject).to be_valid }
    end

    context 'with rules defined' do
      Given do
        class Dad
          insist :name do |essence|
            essence.name == 'Bill'
          end

          insist :age, 'Not old enough' do |essence|
            essence.age > 50
          end
        end
      end

      context 'when one rule is broken' do
        Given(:essence) { OpenStruct.new name: 'Homer', age: 51 }
        Then { expect(subject).to_not be_valid }
        And { subject.messages[:name] == 'Invalid name' }
        And { expect(subject.messages[:age]).to be_nil }
      end

      context 'when multiple rules are broken' do
        Given(:essence) { OpenStruct.new name: 'Homer', age: 43 }
        Then { expect(subject).to_not be_valid }
        And { subject.messages[:name] == 'Invalid name' }
        And { subject.messages[:age] == 'Not old enough' }
      end

      context 'when no rules are broken' do
        Given(:essence) { OpenStruct.new name: 'Bill', age: 54 }
        Then { expect(subject).to be_valid }
        And { expect(subject.messages).to be_empty }
      end
    end
  end
end
