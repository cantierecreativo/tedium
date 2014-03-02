class VirtualDateElement
  attr_reader :root_element, :attribute_name

  def initialize(root_element, attribute_name)
    @root_element = root_element
    @attribute_name = attribute_name
  end

  def set(date)
    year_element.set(date.year)
    month_element.set(date.month)
    day_element.set(date.day)
  end

  def year_element
    token_element('1i')
  end

  def month_element
    token_element('2i')
  end

  def day_element
    token_element('3i')
  end

  private

  def token_element(token)
    root_element.find :input_for_field, "#{attribute_name}(#{token})"
  end
end

