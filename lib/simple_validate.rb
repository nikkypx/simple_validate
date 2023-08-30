# frozen_string_literal: true

%w[base
   presence_of
   format_of
   type_of
   length_of
   inclusion_of
   exclusion_of].each do |validation|
     require "simple_validate/validates_#{validation}"
   end

require "simple_validate/errors"
require "simple_validate/version"
require "simple_validate/utils"

module SimpleValidate
  def self.included(klass)
    klass.extend(ClassMethods)
    klass.include(InstanceMethods)
  end

  module InstanceMethods
    def valid?
      self.class.validate(self)
    end

    def invalid?
      !valid?
    end

    def errors
      @errors ||= Errors.new
    end
  end

  module ClassMethods
    def method_missing(method, *args, &block)
      if respond_to?(method)
        add_validations(args, const_get(Utils.camelize(method)))
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      method.to_s =~ /(validates_
                       (format|
                        presence|
                        type|
                        inclusion|
                        exclusion|
                        length)_of)
      /x || super
    end

    def add_validations(args, klass)
      options = Utils.extract_options! args
      args.each do |attr|
        validations << klass.new(attr, options)
      end
    end

    def validations
      @validations ||= []
    end

    def validate(instance)
      instance.errors.clear!

      validations.each do |validation|
        if validation.condition.call && !validation.valid?(instance)
          instance.errors.add(validation.attribute, validation.message)
        end
      end
      instance.errors.empty?
    end
  end
end
