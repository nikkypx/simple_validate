# frozen_string_literal: true

module SimpleValidate
  class ValidatesTypeOf < ValidatesBase
    SUPPORTED_TYPES = %i[string integer float].freeze

    def initialize(attribute, options)
      @type = options[:as]

      raise ArgumentError unless @type && SUPPORTED_TYPES.include?(@type)

      @klass = Utils.classify(options[:as])

      super(attribute, options[:message] ||
        "must be #{Utils.article(@type)} #{@type}", options[:if] || proc { true })
    end

    def valid?(instance)
      instance.send(attribute).is_a?(@klass)
    end
  end
end
