require 'spec_helper'

describe 'Given any SitePrism page object' do
  let(:page_object) { SitePrism::Page.new }
  let(:record) { Project.new(12) }

  before do
    visit 'record'
  end

  it 'I can use the have_selector matcher' do
    expect(page_object).to have_record(record)
  end
end

