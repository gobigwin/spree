require 'spec_helper'

describe Spree::Promotion::Rules::BillAddressCountry do

  let(:rule) { Spree::Promotion::Rules::BillAddressCountry.new }
  let(:order) { mock_model(Spree::Order ) }
  let(:billing_address) {FactoryGirl.create(:address, :country_id => 1)}
  
  it "should be eligible with a matching country_id" do
    order.stub :billing_address => billing_address
    rule.stub(:preferred_country_id => 1)
    rule.should be_eligible(order)
  end

  it "should not be eligible with a non-matching country_id" do
    order.stub :billing_address => mock(:address, :country_id => 3)
    rule.stub(:preferred_country_id => 49)
    rule.should_not be_eligible(order)
  end
end
