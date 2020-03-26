module ShipStation
  class InternationalOptions
    attr_accessor :contents,
      :customsItems,
      :nonDelivery

    def initialize
      self.nonDelivery = "return_to_sender"
      self.contents = "merchandise"
    end

    def add_item(description, quantity, value, country)

      self.customsItems ||= []

      item = {description: description, quantity: quantity, value: (value / quantity).round(2), countryOfOrigin: country}

      self.customsItems << item


    end


    def to_json(t)
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.gsub("@","").to_sym] = self.instance_variable_get var
      end
      hash.to_json
    end

  end
end
