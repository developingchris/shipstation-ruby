require 'hashie/mash'

module ShipStation
  class Client
    class Response < Hashie::Mash
      disable_warnings
    end
  end
end
