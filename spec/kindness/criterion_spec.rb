require 'ostruct'

RSpec.describe Kindness::Criterion do
  Given do
    class Dad
      extend Kindness
    end
  end

  Given(:essence) { OpenStruct.new name: 'Homer', age: 43 }
  When(:subject) { Dad[essence] }

  describe '#valid?' do
    context 'with no rules defined' do
      Then { expect(subject).to be_valid }
    end

    context 'with :age rule defined' do
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

      Then { expect(subject).to_not be_valid }
      And { subject.messages[:name] == 'Invalid name' }
      And { subject.messages[:age] == 'Not old enough' }
    end
  end
end
