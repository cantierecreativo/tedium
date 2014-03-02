# Tedium

[![Build Status](https://travis-ci.org/cantierecreativo/tedium.png?branch=master)](https://travis-ci.org/cantierecreativo/tedium)

Remove the tedium of formulaic form filling with SitePrism and Capybara. Tedium allows you to specify a set of fields and actions to be performed rather than procedurally calling Capybara’s DSL methods on SitePrism elements.

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

## SitePrism DSL extensions

### field

```ruby
field(name, attribute_name = name)
```

Declares the presence of a field within the page. The selector used to find the input relies on Rails `name="model[attribute]"` attribute convention: `[name$="[attribute]"]`

If the underlying attribute name differs from the name you want to give to the page object field, provide the attribute name as the second argument.

Once a `:foobar` field is declared, the page object will define a `#foobar_field` method, which will return the corresponding Capybara node.
element.

### fields

```ruby
fields(*names)
```

If you need to declare multiple fields at once, you can use this batch method.

### submit_button

```ruby
submit_button(role = nil)
```

Declares the presence of a submit button within the page. It can be either a `input[type=select]` or a `button`. If you pass an argument to the method (ie. `submit_button :sign_in`), the selector will be augmented with a `[role='sign-in']` filter (please note the automatic *dasherization*).

Once the submit button is declared, the page object will define a `#submit!`
method which will press the button.

### submission

```ruby
submission(name, fields)
```

Declares a submission process.

Given the following page:

```ruby
class SignInPage < SitePrism::Page
  fields :name, :email, :terms_of_service
  submit_button

  submission :sign_in, %w(name email terms_of_service)
end
```

The page object will define a `#sign_in!` method, which will perform the following steps:

```ruby
def sign_in!(name, email, terms_of_service)
  name_field.set(name)
  email_field.set(email)
  terms_of_service_field.set(terms_of_service)
  submit!
end
```

