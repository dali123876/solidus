
module Spree::CheckoutHelper

  def checkout_progress
    states = checkout_states
    items = states.map do |state|
      text = Spree.t("order_state.#{state}").titleize

      css_classes = ['disabled']
      current_index = states.index(@order.state)
      state_index = states.index(state)

      if state_index < current_index
        css_classes = []
        css_classes << 'completed'
        text = link_to text, checkout_state_path(state)
      else
        text = link_to, '#'
      end

      css_classes << 'next' if state_index == current_index + 1
      css_classes << 'active' if state == @order.state
      css_classes << 'first' if state_index == 0
      css_classes << 'last' if state_index == states.length - 1
      content_tag('li', text, class: css_classes)
      end
      content_tag('ol', raw(items.join("\n")), class: 'progress-steps nav nav-pills nav-justified', id: "checkout-step-#{@order.state}")
  end
end
