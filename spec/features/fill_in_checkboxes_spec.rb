require 'spec_helper'

describe 'Given a SitePrism page object with a checkbox field' do
  let(:page_object) { page_object_klass.new }

  let(:page_object_klass) do
    Class.new(SitePrism::Page) do
      field :terms_of_service
    end
  end

  before do
    visit 'checkbox'
  end

  it 'fills up the field' do
    page_object.terms_of_service_field.set true
    expect(page_object.terms_of_service_field).to be_checked
  end
end

