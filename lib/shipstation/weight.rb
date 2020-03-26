module Shipstation
  class Weight
    attr_accessor :value, :units

    def in_lbs(lbs)
      self.units = "pounds"
      self.value = lbs
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
