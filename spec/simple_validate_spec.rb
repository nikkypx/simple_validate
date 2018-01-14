require 'spec_helper'

RSpec.describe SimpleValidate do
  describe 'multiple validation errors' do
    before(:each) do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :age

        validates_presence_of :age
        validates_numericality_of :age
      end
    end

    it 'it will contain array of errors' do
      instance = @klass.new
      instance.valid?
      expect(instance.errors.on(:age)).to eq(
        ["can't be empty", 'must be a number']
      )
    end
  end
end
