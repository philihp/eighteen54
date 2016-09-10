module InstancesHelper

  def guilder(amount)
    number_to_currency(amount, precision: 0, format: "%n %u", unit: 'G. ')
  end

  def par_set_option(player, amount)
    "<option>#{amount}</option>".html_safe if(player.wallet >= amount * 4)
  end

end
