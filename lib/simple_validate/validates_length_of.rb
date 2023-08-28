# frozen_string_literal: true

module SimpleValidate
  class ValidatesLengthOf < ValidatesBase
    class InvalidLengthOption < ArgumentError; end
    attr_reader :attribute
    attr_accessor :options

    VALID_LENGTH_OPTIONS = %i[maximum minimum in is].freeze

    def initialize(attribute, options)
      super(attribute, options.delete(:message), options.delete(:if) ||
        proc { true })
      self.options = options
    end

    def message
      @message ||= case validator
                   when :minimum
                     "is too short"
                   when :maximum
                     "is too long"
                   else
                     "is not the correct length"
                   end
    end

    def validator
      options.keys.first
    end

    def valid_length
      options.values.first
    end

    def valid_length?(actual_length)
      case validator
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
      raise ArgumentError, "Only one length argument can be provided" if options.keys.size > 1

      unless VALID_LENGTH_OPTIONS.include?(options.keys.first)
        raise InvalidLengthOption, "Invalid length option given #{options.keys}"
      end

      actual_length = instance.send(attribute)&.length
      valid_length?(actual_length)
    end
  end
end
