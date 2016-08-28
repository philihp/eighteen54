module InstancesHelper

  def guilder(amount)
    number_to_currency(amount, precision: 0, format: "%n %u", unit: 'G. ')
  end

end
