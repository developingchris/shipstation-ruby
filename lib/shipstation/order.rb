module Shipstation
  class Order
    attr_accessor :orderId,
                  :orderNumber,
                  :orderKey,
                  :orderDate,
                  :paymentDate,
                  :shipByDate,
                  :orderStatus,
                  :customerId,
                  :customerUsername,
                  :customerEmail,
                  :billTo,
                  :shipTo,
                  :items,
                  :amountPaid,
                  :taxAmount,
                  :shippingAmount,
                  :customerNotes,
                  :internalNotes,
                  :gift,
                  :giftMessage,
                  :paymentMethod,
                  :requestedShippingService,
                  :carrierCode,
                  :serviceCode,
                  :packageCode,
                  :confirmation,
                  :shipDate,
                  :weight,
                  :dimensions,
                  :insuranceOptions,
                  :internationalOptions,
                  :advancedOptions

    def initialize
      self.orderNumber= ""
      self.orderDate= ""
      self.weight = Weight.new
      self.billTo = Address.new
      self.shipTo = Address.new
      self.items = []
      self.internationalOptions = InternationalOptions.new
      self.advancedOptions = OrderAdvancedOptions.new
    end

    def to_json
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.gsub("@","").to_sym] = self.instance_variable_get var
      end
      hash.to_json
    end

  end
end
