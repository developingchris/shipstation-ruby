module ShipStation
  class OrderAdvancedOptions
    attr_accessor :customField1, :customField2, :saturdayDelivery


    def to_json(t)
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.gsub("@","").to_sym] = self.instance_variable_get var
      end
      hash.to_json
    end

  end
end
