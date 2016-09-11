module ApplicationHelper

  def nav_style(instance)
    return '' if instance.try(:active_player).nil?
    color = Player::COLORS[instance.active_player.turn_order]
    "background-color: #{color}"
  end

  def bootstrap_class_for flash_type
    case flash_type.to_sym
    when :success
      "alert-success"
    when :error
      "alert-danger"
    when :alert
      "alert-warning"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end
end
