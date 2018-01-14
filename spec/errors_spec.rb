require 'spec_helper'

RSpec.describe SimpleValidate::Errors do
  describe '#full_messages' do
    it 'array has one item for one validation error' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_presence_of :name
      end
      instance = @klass.new
      instance.valid?

      expect(instance.errors.full_messages).to eq(["Can't be empty"])
    end

    it 'array has two items for two validation errors' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :age

        validates_presence_of :age
        validates_numericality_of :age
      end
      instance = @klass.new
      instance.valid?

      expect(instance.errors.full_messages).to eq(
        ["Can't be empty", 'Must be a number']
      )
    end
  end
end
