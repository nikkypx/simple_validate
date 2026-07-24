# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with format" do
    context "when valid" do
      it do
        user = Class.new(Struct.new(:code)) do
          include SimpleValidate

          validates_format_of :code, with: /\A[A-Z]+\z/
        end

        u = user.new
        u.code = "ABC"

        expect(u.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        user = Class.new(Struct.new(:code)) do
          include SimpleValidate

          validates_format_of :code, with: /\A[A-Z]+\z/
        end

        u = user.new
        u.code = "abc"

        expect(u.valid?).to eq(false)
        expect(u.errors.messages[:code]).to include("is incorrect format")
      end
    end
  end

  context "with allow_nil" do
    it "returns true for nils" do
      user = Class.new(Struct.new(:code)) do
        include SimpleValidate

        validates_format_of :code, with: /\A[A-Z]+\z/, allow_nil: true
      end

      expect(user.new.valid?).to eq(true)
    end
  end

  context "without a :with option" do
    it "raises an ArgumentError at definition time" do
      expect do
        Class.new(Struct.new(:code)) do
          include SimpleValidate

          validates_format_of :code
        end
      end.to raise_error(ArgumentError, /:with option/)
    end
  end
end
