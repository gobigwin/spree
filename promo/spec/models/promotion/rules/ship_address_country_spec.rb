require 'spec_helper'

describe Spree::Promotion::Rules::ShipAddressCountry do

  let(:rule) { Spree::Promotion::Rules::ShipAddressCountry.new }
  let(:order) { mock_model(Spree::Order ) }
  let(:ship_address) {FactoryGirl.create(:address, :country_id => 1)}
  
  it "should be eligible with a matching country_id" do
    order.stub :shipping_address => ship_address
    rule.stub(:preferred_country_id => 1)
    rule.should be_eligible(order)
  end

  it "should not be eligible with a non-matching country_id" do
    order.stub :shipping_address => mock(:address, :country_id => 3)
    rule.stub(:preferred_country_id => 49)
    rule.should_not be_eligible(order)
  end
end
