require 'spec_helper'

describe 'Given a SitePrism page object with a date field' do
  let(:page_object) { page_object_klass.new }

  let(:page_object_klass) do
    Class.new(SitePrism::Page) do
      date_field :date_of_birth
    end
  end

  before do
    visit 'date'
  end

  it 'fills up all the tokens' do
    page_object.date_of_birth_field.set Date.new(1985, 2, 15)

    expect(page_object.date_of_birth_field.year_node.value).to eq '1985'
    expect(page_object.date_of_birth_field.month_node.value).to eq '2'
    expect(page_object.date_of_birth_field.day_node.value).to eq '15'
  end
end

