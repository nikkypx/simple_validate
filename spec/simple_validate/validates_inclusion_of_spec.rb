require 'spec_helper'

RSpec.describe SimpleValidate do
  describe '::validates_inclusion_of' do
    before do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :domain
        validates_inclusion_of :domain, in: [:com, :net]
      end
    end

    it '#valid? returns false' do
      expect(@klass.new.valid?).to be(false)
    end

    it '#invalid? returns true' do
      expect(@klass.new.invalid?).to be(true)
    end

    it 'recognizes a value not in the set' do
      @klass.new.domain = 'co'
      expect(@klass.new.valid?).to be(false)
    end

    it 'does not distinguish between symbols and keys' do
      instance = @klass.new
      instance.domain = 'com'
      expect(instance.valid?).to be(true)
    end

    it 'it will contain errors' do
      instance = @klass.new
      instance.valid?
      expect(instance.errors.on(:domain)).to eq(['is not included in set'])
    end
  end

  describe 'errors' do
    it 'raises an ArgumentError if the with option is not supplied' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :domain
        validates_inclusion_of :domain
      end
      instance = @klass.new
      expect { instance.valid? }.to raise_error(ArgumentError)
    end

    it 'raises an ArgumentError if the with option is not supplied an Array' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :domain
        validates_inclusion_of :domain, in: 'not an array'
      end
      instance = @klass.new
      expect { instance.valid? }.to raise_error(ArgumentError)
    end
  end
end
