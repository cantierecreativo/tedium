require 'capybara/dsl'
require 'tedium'
require 'pry'

require 'active_support/core_ext/object/blank'
require 'action_view/record_identifier'
require 'active_model'

class Project < Struct.new(:id)
  extend ActiveModel::Naming
  include ActiveModel::Conversion
end

module SpecHelper
  def visit(page_name)
    page.visit("/#{page_name}.html")
  end

  def page
    @page ||= begin
                Capybara.app = Rack::File.new(File.expand_path('../fixtures', __FILE__))
                Capybara.current_session
              end
  end
end

RSpec.configure do |c|
  c.include SpecHelper
end

