# frozen_string_literal: true

module SimpleValidate
  class Errors
    attr_reader :messages

    def initialize
      @messages = {}
    end

    def add(attribute, message)
      if @messages.key?(attribute)
        @messages[attribute] << message
      else
        @messages[attribute] = Array(message)
      end
    end

    def on(key)
      @messages.fetch(key)
    end

    def empty?
      @messages.empty?
    end

    def full_messages
      @messages.values.flatten.map(&:capitalize)
    end
  end
end
