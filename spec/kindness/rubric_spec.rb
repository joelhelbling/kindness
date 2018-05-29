require 'ostruct'

RSpec.describe Kindness::Rubric do
  Given do
    class Dad
      extend Kindness
    end
  end

  Given(:essence) { OpenStruct.new name: 'Homer', age: 43 }
  When(:subject) { Dad[essence] }

  describe '#valid?' do
    context 'with no rubrics defined' do
      Then { expect(subject).to be_valid }
    end

    context 'with :age rubric defined' do
      Given do
        class Dad
          rubric :name do |essence|
            essence.name == 'Bill'
          end

          rubric :age, 'Not old enough' do |essence|
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
