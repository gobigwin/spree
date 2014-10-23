require 'spec_helper'

describe Spree::Promotion::Rules::CurrentStore do
  let(:rule) { Spree::Promotion::Rules::CurrentStore.new }
  let(:order) { mock_model(Spree::Order, :store_id => 10 ) }

  it "should be eligible with a matching store_id" do
    rule.stub(:preferred_store_id => 10)
    rule.should be_eligible(order)
  end

  it "should not be eligible with a non-matching store_id" do
    rule.stub(:preferred_store_id => 5)
    rule.should_not be_eligible(order)
  end
end
