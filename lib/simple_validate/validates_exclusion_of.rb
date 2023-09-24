# frozen_string_literal: true

module SimpleValidate
  class ValidatesExclusionOf < ValidatesBase
    def initialize(attribute, options)
      @set = options[:in]
      @allow_nil = options[:allow_nil]

      raise ArgumentError unless [Array, Range].include?(@set.class)

      super(attribute, options[:message] ||
        "breaks exclusion rules", options[:if] || proc { true })
    end

    def valid?(instance)
      return true if super

      !@set.to_a.include?(@val)
    end
  end
end
