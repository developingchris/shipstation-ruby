module Shipstation
  class Dimensions
    attr_accessor :units, :length, :width, :height
  end

    def initialize(length,width,height,unit)
      self.length = length
      self.width = width
      self.height = height
      self.units = unit
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
