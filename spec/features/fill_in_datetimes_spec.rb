require 'spec_helper'

describe 'Given a SitePrism page object with a datetime field' do
  let(:page_object) { page_object_klass.new }

  let(:page_object_klass) do
    Class.new(SitePrism::Page) do
      datetime_field :start_at
    end
  end

  before do
    visit 'datetime'
  end

  it 'fills up all the tokens' do
    page_object.start_at_field.set Time.new(2014, 05, 22, 9, 30)

    expect(page_object.start_at_field.year_element.value).to eq '2014'
    expect(page_object.start_at_field.month_element.value).to eq '5'
    expect(page_object.start_at_field.day_element.value).to eq '22'
    expect(page_object.start_at_field.hour_element.value).to eq '09'
    expect(page_object.start_at_field.minute_element.value).to eq '30'
  end
end

