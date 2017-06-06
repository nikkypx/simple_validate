require "spec_helper"

RSpec.describe SimpleValidate do
  describe "invalid length" do

    it "will raise an error for an invalid length option" do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name
        validates_length_of :name, foo: 6
      end
      instance = @klass.new

      expect { instance.valid? }.to raise_error(SimpleValidate::ValidatesLengthOf::InvalidLengthOption)
    end
  end

  describe "length is too short" do
    it "will have the correct default error message" do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name

        validates_length_of :name, minimum: 6
      end

      instance = @klass.new
      instance.name = "aaa"
      instance.valid?
      expect(instance.errors.on(:name)).to eq(["is too short"])
    end
  end

  describe "length is too long" do
    it "will have the correct default error message" do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name

        validates_length_of :name, maximum: 10
      end

      instance = @klass.new
      instance.name = "a" * 11
      instance.valid?
      expect(instance.errors.on(:name)).to eq(["is too long"])
    end
  end

  describe "length is not within range" do
    it "will have the correct default error message" do
      @klass = Class.new
      @klass.class_eval do
        include SimpleValidate
        attr_accessor :name

        validates_length_of :name, in: 6..9
      end

      instance = @klass.new
      instance.name = "aaa"
      instance.valid?
      expect(instance.errors.on(:name)).to eq(["is not the correct length"])
    end
  end
end
