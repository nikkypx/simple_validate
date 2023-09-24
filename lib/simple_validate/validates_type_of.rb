# frozen_string_literal: true

module SimpleValidate
  class ValidatesTypeOf < ValidatesBase
    using CoreExt::StringRefinements

    SUPPORTED_TYPES = %i[string integer float boolean].freeze

    def initialize(attribute, options)
      @allow_nil = options[:allow_nil]
      @type = options[:as]

      raise ArgumentError unless @type && SUPPORTED_TYPES.include?(@type)

      super(attribute, options[:message] ||
        "must be #{@type.to_s.article} #{@type}", options[:if] || proc { true })
    end

    def valid?(instance)
      return true if super

      if @type == :boolean
        [true, false].include? @val
      else
        klass = Object.const_get(@type.to_s.to_camel)
        @val.is_a?(klass)
      end
    end
  end
end
