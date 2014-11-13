require 'spec_helper'

describe Spree::Promotion::Rules::ProductExclusion do
  
  let(:rule) { Spree::Promotion::Rules::ProductExclusion.new }
  let(:order) { Spree::Order.new }

  before do
    3.times { |i| instance_variable_set("@product#{i}", mock_model(Spree::Product)) }
  end

  it "should be eligible if there are no products" do
    rule.stub(:eligible_products => [])
    rule.should be_eligible(order)
  end

  it "should not be eligible if any of the products is in eligible products" do
    order.stub(:products => [@product1, @product2])
    rule.stub(:eligible_products => [@product2, @product3])
    rule.should_not be_eligible(order)
  end

  it "should be eligible if none of the products is in eligible products" do
    order.stub(:products => [@product1])
    rule.stub(:eligible_products => [@product2, @product3])
    rule.should be_eligible(order)
  end
end