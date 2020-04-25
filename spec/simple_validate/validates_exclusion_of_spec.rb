# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SimpleValidate do
  describe '::validates_exclusion_of' do
    before do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_exclusion_of :name, in: %i[Jack Mary]
      end
    end

    it '#valid? returns false' do
      instance = @klass.new
      expect(instance.valid?).to be(true)
    end

    it '#invalid? returns true' do
      expect(@klass.new.invalid?).to be(false)
    end

    it 'recognizes a value in the set' do
      instance = @klass.new
      instance.name = :Jack
      expect(instance.valid?).to be(false)
    end

    it 'does not distinguish between symbols and keys' do
      instance = @klass.new
      instance.name = 'Mary'
      expect(instance.valid?).to be(false)
    end

    it 'it will contain errors' do
      instance = @klass.new
      instance.name = 'Mary'
      instance.valid?
      expect(instance.errors.on(:name)).to eq(
        ['breaks inclusion/exclusion rules']
      )
    end
  end

  describe 'errors' do
    it 'raises an ArgumentError if the with option is not supplied' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_exclusion_of :name
      end
      instance = @klass.new
      expect { instance.valid? }.to raise_error(ArgumentError)
    end

    it 'raises an ArgumentError if the with option is not supplied an Array' do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_exclusion_of :name, in: 'not an array'
      end
      instance = @klass.new
      expect { instance.valid? }.to raise_error(ArgumentError)
    end
  end
end
