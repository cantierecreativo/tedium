require "tedium/version"

require "tedium/capybara/selectors"
require "tedium/capybara/node_element"

require "tedium/site_prism/form_dsl"
require "tedium/site_prism/action_dsl"
require "tedium/site_prism/has_record"
require "tedium/site_prism/root_element_or_page"

require "site_prism"

[SitePrism::Page, SitePrism::Section].each do |klass|
  klass.send :extend, Tedium::SitePrism::FormDsl
  klass.send :extend, Tedium::SitePrism::ActionDsl
  klass.send :include, Tedium::SitePrism::HasRecord
  klass.send :include, Tedium::SitePrism::RootElementOrPage
end

require 'capybara/node/element'

Capybara::Node::Element.send(:include, Tedium::Capybara::NodeElement)

