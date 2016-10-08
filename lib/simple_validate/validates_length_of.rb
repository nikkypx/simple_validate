module SimpleValidate
  class ValidatesLengthOf < ValidatesBase
    attr_reader :attribute
    class InvalidLengthOption < ArgumentError; end

    VALID_LENGTH_OPTIONS = %i(maximum minimum in is)

    def initialize(attribute, options)
      super(attribute, options.delete(:message), options.delete(:if) || Proc.new { true })
      @options          = options
      check_options(@options)
      @length_validator = @options.select { |k, _| VALID_LENGTH_OPTIONS.include?(k) }
    end

    def message
      @message ||= begin
                     case @length_validator.keys.first
                     when :minimum
                       'is too short'
                     when :maximum
                       'is too long'
                     else
                       'is not the correct length'
                     end
                   end
    end

    def validator
      @options.entries.first
    end

    def check_options(options)
      if options.keys.size > 1 || !VALID_LENGTH_OPTIONS.include?(options.keys.first)
        raise InvalidLengthOption, "Invalid length option given #{@options.keys}"
      end
    end

    def valid_length?(actual_length)
      validator_key, valid_length = @length_validator.entries.first
      case validator_key
      when :minimum
        actual_length >= valid_length
      when :maximum
        actual_length <= valid_length
      when :in
        valid_length.member?(actual_length)
      when :is
        actual_length == valid_length
      end
    end

    def valid?(instance)
      actual_length = instance.send(attribute).length
      valid_length?(actual_length)
    end
  end
end
