# frozen_string_literal: true

module SimpleValidate
  class ValidatesNumericalityOf < ValidatesBase
    def initialize(attribute, options)
      super(attribute, options[:message] ||
        'must be a number', options[:if] || proc { true })
    end

    def valid?(instance)
      instance.send(attribute).is_a?(Numeric)
    end
  end
end
