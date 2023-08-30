# frozen_string_literal: true

module SimpleValidate
  class ValidatesTypeOf < ValidatesBase
    SUPPORTED_TYPES = %i[string integer float boolean].freeze

    def initialize(attribute, options)
      @allow_nil = options[:allow_nil]
      @type = options[:as]

      raise ArgumentError unless @type && SUPPORTED_TYPES.include?(@type)

      super(attribute, options[:message] ||
        "must be #{Utils.article(@type)} #{@type}", options[:if] || proc { true })
    end

    def valid?(instance)
      val = instance.send(attribute)

      return true if val.nil? && @allow_nil == true

      if @type == :boolean
        [true, false].include? val
      else
        klass = Utils.classify(@type)
        val.is_a?(klass)
      end
    end
  end
end
