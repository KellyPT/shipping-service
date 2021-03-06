require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase


  test "create a valid Shipment object" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert shipment.valid?
  end

  test "can't create a Shipment without a weight" do
    ship_hash = {
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

      shipment = Shipment.new(ship_hash)
      assert_not shipment.valid?
      assert_includes shipment.errors, :weight
  end

  test "weight must be greater than 0" do
    ship_hash = {
      weight: 0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_not shipment.save
    assert_equal ["must be greater than 0"], shipment.errors.messages[:weight]
  end

  test "can't create a Shipment without a height" do
    ship_hash = {
      weight: 100.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :height
  end

  test "height must be greater than 0" do
    ship_hash = {
      weight: 100.0,
      height: 0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_not shipment.save
    assert_equal ["must be greater than 0"], shipment.errors.messages[:height]
  end

  test "can't create a Shipment without a length" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :length
  end

  test "length must be greater than 0" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_not shipment.save
    assert_equal ["must be greater than 0"], shipment.errors.messages[:length]
  end

  test "can't create a Shipment without a width" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :width
  end

  test "width must be greater than 0" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_not shipment.save
    assert_equal ["must be greater than 0"], shipment.errors.messages[:width]
  end

  test "can't create a Shipment without a city" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

  shipment = Shipment.new(ship_hash)
  assert_not shipment.valid?
  assert_includes shipment.errors, :city
  end

  test "can't create a Shipment without a state" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      country: "US",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :state
  end


  test "can't create a Shipment without a country" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      zipcode: "89121",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :country
  end

  test "can't create a Shipment without a zipcode" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      units: "imperial"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :zipcode
  end

  test "can't create a Shipment without unit" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_includes shipment.errors, :units
  end

  test "can't create a shipment unless the unit is metric or imperial" do
    ship_hash = {
      weight: 100.0,
      height: 12.0,
      length: 12.0,
      width: 12.0,
      city: "Las Vegas",
      state: "NV",
      country: "US",
      zipcode: "89121",
      units: "foo"
    }

    shipment = Shipment.new(ship_hash)
    assert_not shipment.valid?
    assert_not shipment.save
    assert_equal ["#{shipment[:units]} is not a valid unit"], shipment.errors.messages[:units]
  end

  test "#package will return a Package object" do
    shipment = shipments(:one)
    package = shipment.package
    assert_instance_of ActiveShipping::Package, package
  end

  test "#weight_conversion on a package measured in metric system will return the same weight value" do
    shipment = shipments(:two)
    metric_weight = shipment.weight_conversion(shipment.weight)
    assert_equal metric_weight, shipment.weight
  end

  test "#weight_conversion on a package measured in imperial system will return the weight value times 16" do
    shipment = shipments(:one)
    imperial_weight = shipment.weight_conversion(shipment.weight)
    assert_equal imperial_weight, (shipment.weight*16)
  end

  test "#origin returns a Location object" do
    shipment = shipments(:one)
    origin = shipment.origin
    assert_instance_of ActiveShipping::Location, origin
  end

  test "#destination returns a Location object" do
    shipment = shipments(:one)
    destination = shipment.destination
    assert_instance_of ActiveShipping::Location, destination

    assert_equal shipment.city, destination.city
    assert_equal shipment.state, destination.state
    assert_equal shipment.country, destination.country.name
    assert_equal shipment.zipcode, destination.postal_code
  end

  # reason: we don't know if UPS impose a limit on the number of times we can call their API
  test "#ups_rates would return an array of UPS rates" do
    VCR.use_cassette("shipments") do
      ups_rates = shipments(:one).ups_rates
      assert_instance_of Array, ups_rates
      ups_rates.each do |rate|
        assert_instance_of ActiveShipping::RateEstimate, rate
      end
    end
  end

  test "#usps_rates would return an array of USPS rates" do
    VCR.use_cassette("shipments") do
      usps_rates = shipments(:one).usps_rates
      assert_instance_of Array, usps_rates
      usps_rates.each do |rate|
        assert_instance_of ActiveShipping::RateEstimate, rate
      end
    end
  end
end
