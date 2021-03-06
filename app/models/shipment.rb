class Shipment < ActiveRecord::Base
  has_many :rates

  validates :weight, presence: true, numericality: {greater_than: 0, only_integer: false}
  validates :height, presence: true, numericality: {greater_than: 0, only_integer: false}
  validates :length, presence: true, numericality: {greater_than: 0, only_integer: false}
  validates :width, presence: true, numericality: {greater_than: 0, only_integer: false}
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zipcode, presence: true
  validates :units, presence: true, inclusion: { in: %w(metric imperial),
    message: "%{value} is not a valid unit" }

  USPS_LOGIN = "677JADED7283"
  UPS_LOGIN = "shopifolk"
  UPS_PASSWORD = "Shopify_rocks"
  UPS_KEY = "7CE85DED4C9D07AB"

  # Package information
  def weight_conversion(weight)
    if units == "metric"
      weight
    elsif units == "imperial"
      weight = weight * 16
    end
  end

  def package
    return ActiveShipping::Package.new(weight_conversion(weight), [length, width, height], units: :units)
  end

  # Location information
  def origin
    # Normally this wouldn't be hardcoded, but the limitations of the
    # project necessitate it.
    return ActiveShipping::Location.new(country: "United States", state: "WA", city: "Seattle", postal_code: "98161")
  end

  def destination
    return ActiveShipping::Location.new(country: country, state: state, city: city, postal_code: zipcode)
  end

  # Calling UPS and USPS...
  # response = ups.find_rates(origin, destination, packages)
  def ups_rates
    ups = ActiveShipping::UPS.new(login: UPS_LOGIN, password: UPS_PASSWORD, key: UPS_KEY)
    response = ups.find_rates(origin, destination, package)
    response.rates.each do |rate|
      rates << Rate.create(shipment_id: id, service_name: rate.service_name, total_price: rate.total_price)
    end
  end

  def usps_rates
    usps = ActiveShipping::USPS.new(login: USPS_LOGIN)
    response = usps.find_rates(origin, destination, package)
    response.rates.each do |rate|
      rates << Rate.create(shipment_id: id, service_name: rate.service_name, total_price: rate.total_price)
    end
  end
end
