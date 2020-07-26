# frozen_string_literal: true

%w[base
   presence_of
   format_of
   numericality_of
   length_of
   set_base
   inclusion_of
   exclusion_of].each do |validation|
     require "simple_validate/validates_#{validation}"
   end

require 'simple_validate/errors'
require 'simple_validate/version'
require 'active_support/all'

module SimpleValidate
  VALIDATORS = %i[
    exclusion
    format
    inclusion
    length
    numericality
    presence
  ].freeze

  def self.included(klass)
    klass.extend ClassMethods
  end

  def valid?
    self.class.validate self
  end

  def invalid?
    !valid?
  end

  def errors
    @errors ||= Errors.new
  end

  module ClassMethods
    def method_missing(method, *args, &block)
      if respond_to? method
        add_validations(args, const_get(method.to_s.classify))
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      VALIDATORS.map do |v|
        ['validates', v, 'of'].join('_')
      end.include?(method.to_s) || super
    end

    def add_validations(args, klass)
      options = args.extract_options!
      args.each do |attr|
        validations << klass.new(attr, options)
      end
    end

    def validations
      @validations ||= []
    end

    def validate(instance)
      validations.each do |validation|
        if validation.condition.call && !validation.valid?(instance)
          instance.errors.add(validation.attribute, validation.message)
        end
      end
      instance.errors.empty?
    end
  end
end
