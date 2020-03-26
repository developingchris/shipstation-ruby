require 'shipstation/client/mashed_parser'
require 'shipstation/client/response'

module ShipStation
  class Client
    include HTTParty
    base_uri 'https://ssapi.shipstation.com'
    # debug_output

    parser Class.new HTTParty::Parser
    parser.send :include, MashedParser

    def initialize(key, secret)
      @auth = {username:key, password: secret}
    end

    def order(number, status="awaiting_shipment")
      options = {}
      options[:query] = {orderNumber: number, orderStatus: status}

      if status.nil? || status.empty?
        options[:query].delete(:orderStatus)
      end

      authit(options)

      order_result =  self.class.get("/orders",options)

      if order_result && order_result.total
        if order_result.total > 1
          throw Exception.new("Too many results for order query")
        end

        order_result.orders.first unless order_result.orders.nil?
      end
    end

    def orders(params={})
      options = {}

      authit(options)
      options[:query] = params

      order_result =  self.class.get("/orders",options)

      # if order_result["total"] > 1
      #   throw Exception.new("Too many results for order query")
      # end

      order_result.orders
    end

    def order_delete(id)

      options = {}

      authit(options)

      order_result =  self.class.delete("/orders/#{id}" ,options)

      order_result.message
    end

    def carriers
      options = {}
      authit(options)

      self.class.get("/carriers", options)
    end

    def list_services(code)
      options = {}
      authit(options)
      options[:query] = {carrierCode: code }

      self.class.get("/carriers/listservices", options)
    end

    def list_packages(code)
      options = {}
      authit(options)
      options[:query] = {carrierCode: code }

      self.class.get("/carriers/listpackages", options)
    end


    def create_orderlabel(params)
      options = {}
      options[:body] =  params.to_json
      authit(options)
      options[:headers] ||= {}
      options[:headers]["Content-Type"] = "application/json"

      self.class.post("/orders/createlabelfororder", options)
    end

    def create_order(id, params)
      options = {}
      options[:body] =  params
      authit(options)
      options[:headers] ||= {}
      options[:headers]["Content-Type"] = "application/json"

      self.class.post("/orders/createorder", options)
    end

    def check_shipment()
      options = {}
      options[:query] = {batchId: 13653272, includeShipmentItems: false}

      authit(options)

      self.class.get("/shipments", options)
    end

    def list_stores(marketplace = 0)
      options = {}
      authit(options)
      # options[:query] = {showInactive: false }
      options[:query] = {marketplaceId: marketplace } unless marketplace == 0

      self.class.get("/stores", options)
    end

    def refresh_store(store = 0)
      options = {}
      # options[:body] =  {storeId: store}
      authit(options)
      options[:headers] ||= {}
      options[:headers]["Content-Type"] = "application/json"

      self.class.post("/stores/refreshstore", options)
    end

    def mark_order_shipped(id, tracking, carrier_code)
      options = {}
      authit(options)
      options[:headers] ||= {}
      options[:headers]["Content-Type"] = "application/json"

      data = {
        "orderId": id,
        "carrierCode": carrier_code,
        "shipDate":  Time.now.strftime("%Y-%m-%d"),
        "trackingNumber": tracking,
        "notifyCustomer": true,
        "notifySalesChannel": true
      }

      options[:body] = data.to_json
      self.class.post("/orders/markasshipped", options)
    end

    private

    def authit(options)
      options.merge!({basic_auth:  @auth, verify: false})
    end
  end
end
