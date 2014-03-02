require 'spec_helper'

describe 'Given a SitePrism page object with a select field' do
  let(:page_object) { page_object_klass.new }

  let(:page_object_klass) do
    Class.new(SitePrism::Page) do
      field :type
    end
  end

  before do
    visit 'select'
  end

  it '.set selects options by value' do
    page_object.type_field.set 'public'
    expect(page_object.type_field.value).to eq 'public'
  end

  it '.set selects options by label' do
    page_object.type_field.set 'Public: fluff blargh'
    expect(page_object.type_field.value).to eq 'public'
  end
end

