require 'spec_helper'

describe 'Given a SitePrism page object with some fields and a submission' do
  let(:page_object) { page_object_klass.new }

  let(:page_object_klass) do
    Class.new(SitePrism::Page) do
      fields :email, :password
      submit_button :sign_in

      submission :sign_in, %w(email password)
      submission :implicit_sign_in
    end
  end

  before do
    visit 'form'
  end

  it 'finds the email field' do
    expect(page_object.email_field).to be_present
  end

  it 'finds the password field' do
    expect(page_object.password_field).to be_present
  end

  it 'finds the submit button' do
    expect(page_object.submit_button).to be_present
  end

  it 'submits the form' do
    page_object.submit!
    expect(page).to have_content 'Submitted!'
  end

  context do
    before do
      page_object.stub(:submit!)
    end

    it 'performs the submission' do
      page_object.sign_in!('foo@bar.com', 'qux')

      expect(page_object.email_field.value).to eq 'foo@bar.com'
      expect(page_object.password_field.value).to eq 'qux'
      expect(page_object).to have_received(:submit!)
    end

    it 'performs the submission inferring the fields to fill in' do
      page_object.implicit_sign_in!('foo@bar.com', 'qux')

      expect(page_object.email_field.value).to eq 'foo@bar.com'
      expect(page_object.password_field.value).to eq 'qux'
      expect(page_object).to have_received(:submit!)
    end
  end
end

