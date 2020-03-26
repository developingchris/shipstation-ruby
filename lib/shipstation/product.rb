module Shipstation
  class Product
    attr_accessor :lineItemKey,
      :sku,
      :name,
      :imageUrl,
      :weight,
      :quantity,
      :unitPrice,
      :taxAmount,
      :shippingAmount,
      :warehouseLocation,
      :options,
      :productId,
      :fulfillmentSku,
      :adjustment,
      :upc

    def initialize()

    end


     def to_json args
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.gsub("@","").to_sym] = self.instance_variable_get var
      end

      if(hash.empty?)
        return "null"
      end
      hash.to_json
     end
  end
end
