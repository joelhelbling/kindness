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

    def method_missing(method_name, *args, &block)
      if essence.respond_to?(method_name)
        essence.send method_name, *args, &block
      end
    end
  end
end
