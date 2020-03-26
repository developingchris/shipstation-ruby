require 'spec_helper'

RSpec.describe ShipStation do
  it "has a version number" do
    expect(ShipStation::VERSION).not_to be nil
  end
end
