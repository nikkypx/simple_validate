# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with presence" do
    it do
      person = Class.new(Struct.new(:name, :age)) do
        include SimpleValidate

        validates_presence_of :name, :age
      end

      p = person.new

      expect(p.valid?).to eq(false)
      expect(p.errors.messages[:name].size).to eq(1)
      expect(p.errors.messages[:age].size).to eq(1)
      expect(p.errors.messages[:name]).to include("can't be empty")
      expect(p.errors.messages[:age]).to include("can't be empty")
    end
  end
end
