module Kindness
  module Identity
    attr_reader :essence

    def kind_of?(charactaristic)
      essence.kind_of?(charactaristic) ||
        self.class == charactaristic ||
        super
    end

    def is_a?(charactaristic)
      kind_of? charactaristic
    end

    def value
      essence
    end
  end
end
