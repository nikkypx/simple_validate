# frozen_string_literal: true

module SimpleValidate
  class ValidatesTypeOf < ValidatesBase
    SUPPORTED_TYPES = %i[string integer float boolean].freeze

    def initialize(attribute, options)
      @type = options[:as]

      raise ArgumentError unless @type && SUPPORTED_TYPES.include?(@type)

      super(attribute, options[:message] ||
        "must be #{Utils.article(@type)} #{@type}", options[:if] || proc { true })
    end

    def valid?(instance)
      if @type == :boolean
        [true, false].include? instance.send(attribute)
      else
        klass = Utils.classify(@type)
        instance.send(attribute).is_a?(klass)
      end
    end
  end
end
