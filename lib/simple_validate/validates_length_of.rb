# frozen_string_literal: true

module SimpleValidate
  class ValidatesLengthOf < ValidatesBase
    VALIDATORS = %i[maximum minimum in is].freeze

    def initialize(attribute, options)
      @validator = options.keys.first

      raise ArgumentError, "Invalid length option" unless VALIDATORS.include?(@validator)

      @valid_length = options[@validator]
      @allow_nil = options[:allow_nil]

      super(attribute, options[:message], options[:if] || proc { true })
    end

    def message
      @message = case @validator
                 when :minimum
                   "is too short"
                 when :maximum
                   "is too long"
                 else
                   "is not valid length"
                 end
    end

    def valid_length?(actual_length)
      case @validator
      when :minimum
        actual_length >= @valid_length
      when :maximum
        actual_length <= @valid_length
      when :in
        @valid_length.member?(actual_length)
      when :is
        actual_length == @valid_length
      end
    end

    def valid?(instance)
      val = instance.send(attribute)

      return true if val.nil? && @allow_nil == true

      actual_length = val&.length
      valid_length?(actual_length)
    end
  end
end
