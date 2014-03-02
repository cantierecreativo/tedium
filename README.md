# Tedium

[![Build Status](https://travis-ci.org/cantierecreativo/tedium.png?branch=master)](https://travis-ci.org/cantierecreativo/tedium)

Remove the tedium of formulaic form filling with SitePrism and Capybara.
Tedium allows you to specify a set of fields and actions to be performed rather
than procedurally calling Capybara’s DSL methods on SitePrism elements.

## Usage

```ruby
class SignInPage < SitePrism::Page
  fields :name, :email, :terms_of_service
  submit_button

  submission :sign_in, %w(name email terms_of_service)
end

feature 'New user registration' do
  let(:sign_in_page) { SignInPage.new }

  scenario 'successfull sign up' do
    sign_in_page.load
    sign_in_page.sign_in!('Stefano', 's.verna@cantierecreativo.net', true)
    expect(page).to have_content t('user.create.success')
  end
end
```

