require 'spec_helper'

describe 'Given a SitePrism page object with an action' do
  let(:page_object) { page_object_klass.new }

  let(:page_object_klass) do
    Class.new(SitePrism::Page) do
      action :follow_project
    end
  end

  before do
    visit 'action'
  end

  it 'finds the action element' do
    expect(page_object.follow_project_element).to be_present
  end

  it 'performs the action' do
    page_object.follow_project!
    expect(page).to have_content 'Followed!'
  end
end

