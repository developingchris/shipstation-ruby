module ShipStation
class Address
    attr_accessor :name,
                  :company,
                  :street1,
                  :street2,
                  :street3,
                  :city,
                  :state,
                  :postalCode,
                  :country,
                  :phone,
                  :residential

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
