require 'spec_helper'

describe VatRateHelper do
  before do
    FactoryGirl.create(:vat_rate)
  end

  describe "#vat_rates_as_collection" do
    it "returns the VAT rates" do
      expect(helper.vat_rates_as_collection).to eq({"8.7" => "vat:normal"})
    end
  end
end
