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
      val = instance.send(attribute)

      return true if val.nil? && @allow_nil == true

      !@set.to_a.include?(val)
    end
  end
end
