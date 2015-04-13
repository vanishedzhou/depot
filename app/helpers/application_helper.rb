module ApplicationHelper
  def hidden_div_if condition, attributions = {}, &block
    if condition
      attributions["style"] = "display: none"
    end
    content_tag "div", attributions, &block
  end
end

