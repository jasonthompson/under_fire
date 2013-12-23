require_relative '../../spec_helper'
require 'ox'

module UnderFire
  describe Registration do
    describe "instantiation" do
      subject {Registration.new("123435-134325325")}

      describe "#query" do
        it "returns well formed XML" do
          Ox.load(subject.query).must_be_kind_of Ox::Element
        end

        it "returns the correct XML query" do
          subject.query.must_include "123435-134325325"
        end
      end
    end
  end
end
