require 'httparty'
require_relative "shipstation/version"
require_relative 'shipstation/address.rb'
require_relative 'shipstation/dimensions.rb'
require_relative 'shipstation/order_advanced_options.rb'
require_relative 'shipstation/international_options.rb'
require_relative 'shipstation/order.rb'
require_relative 'shipstation/product.rb'
require_relative 'shipstation/product_option.rb'
require_relative 'shipstation/weight.rb'
require_relative 'shipstation/client.rb'

module ShipStation
  class Error < StandardError; end
end

