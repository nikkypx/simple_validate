require 'spec_helper'

RSpec.describe SimpleValidate do
  describe 'invalid format' do
    before do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_format_of :name, with: /.+/
      end
    end

    it '#valid? returns false' do
      expect(@klass.new.valid?).to be(false)
    end

    it '#invalid? returns true' do
      expect(@klass.new.invalid?).to be(true)
    end

    it 'it will contain errors' do
      instance = @klass.new
      instance.valid?
      expect(instance.errors.on(:name)).to eq(['is incorrect format'])
    end
  end

  describe '::validates_format_of' do
    it 'raises an ArgumentError if the with option is not supplied' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_format_of :name
      end
      instance = @klass.new
      expect { instance.valid? }.to raise_error(ArgumentError)
    end

    it 'raises an ArgumentError if the with option is not supplied a regexp' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_format_of :name, with: 4
      end
      instance = @klass.new
      expect { instance.valid? }.to raise_error(ArgumentError)
    end
  end
end
