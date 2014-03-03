class VirtualDateTimeElement < VirtualDateElement
  def set(datetime)
    super datetime
    hour_element.set(datetime.hour.to_s.rjust(2, '0'))
    minute_element.set(datetime.min.to_s.rjust(2, '0'))
  end

  def hour_element
    token_element('4i')
  end

  def minute_element
    token_element('5i')
  end
end

