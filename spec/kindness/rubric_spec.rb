require 'ostruct'

RSpec.describe Kindness::Rubric do
  Given do
    class Dad
      extend Kindness
    end
  end

  Given(:essence) { OpenStruct.new name: 'Mel', age: 43 }
  When(:subject) { Dad[essence] }

  describe '#valid?' do
    context 'default' do
      Then { expect(subject).to be_valid }
    end

    context 'overridden' do
      Given do
        class Dad
          def valid?
            essence.age > 50
          end
        end
      end

      Then { expect(subject).to_not be_valid }
    end
  end
end
