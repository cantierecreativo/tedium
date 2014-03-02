require "capybara"

Capybara.add_selector(:input_for_field) do
  label 'input for field'

  xpath do |field|
    XPath.descendant[
      XPath.attr(:name).contains("[#{field}]") &
      XPath.attr(:type).equals('hidden').inverse
    ]
  end
end

Capybara.add_selector(:role) do
  label 'element with role'

  xpath do |role|
    role = role.to_s.gsub(/_/, '-')
    XPath.descendant[XPath.attr(:role).equals(role)]
  end
end

Capybara.add_selector(:submit_button) do
  label 'submit button'

  xpath do |role = nil|

    selectors = [
      XPath.descendant(:input)[XPath.attr(:type).equals('submit')],
      XPath.descendant(:button)
    ]

    if role
      role = role.to_s.gsub(/_/, '-')
      selectors.map! do |selector|
        selector[XPath.attr(:role).equals(role)]
      end
    end

    selectors.inject(&:+)
  end
end

Capybara.add_selector(:record) do
  xpath do |record|
    dom_id = record_identifier.dom_id(record)
    XPath.descendant[XPath.attr(:id).equals(dom_id)]
  end

  match do |record|
    record.is_a?(ActiveModel::Naming)
  end

  def record_identifier
    if defined?(ActionView::RecordIdentifier)
      ActionView::RecordIdentifier
    elsif defined?(ActionController::RecordIdentifier)
      ActionController::RecordIdentifier
    else
      raise 'No RecordIdentifier found!'
    end
  end
end

Capybara.add_selector :option_with_value_or_label do
  label 'option with value or label'

  xpath do |value|
    XPath.descendant(:option)[XPath.text.equals(value) | XPath.attr(:value).equals(value)]
  end
end

