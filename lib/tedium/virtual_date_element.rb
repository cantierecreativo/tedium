class VirtualDateElement
  attr_reader :root_element, :attribute_name

  def initialize(root_element, attribute_name)
    @root_element = root_element
    @attribute_name = attribute_name
  end

  def set(date)
    year_node.set(date.year)
    month_node.set(date.month)
    day_node.set(date.day)
  end

  def year_node
    token_node('1i')
  end

  def month_node
    token_node('2i')
  end

  def day_node
    token_node('3i')
  end

  private

  def token_node(token)
    root_element.find :input_for_field, "#{attribute_name}(#{token})"
  end
end

