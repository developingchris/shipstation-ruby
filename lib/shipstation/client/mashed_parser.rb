module ShipStation
	class Client
    # Turns XML, JSON and YAML bodies into `Hashie::Mash`s.
		module MashedParser
			protected
			def xml
				mashed super
			end

			def json
				mashed super
			end

			def yaml
				mashed super
			end

			private

			def mashed thing
				if thing.is_a? Hash
          Response.new thing
				elsif thing.is_a? Array
					thing.map &method(:mashed)
				else
					thing
				end
			end
		end
  end
end
