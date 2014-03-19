# Tedium

[![Gem Version](https://badge.fury.io/rb/tedium.png)](http://badge.fury.io/rb/tedium)
[![Build Status](https://travis-ci.org/cantierecreativo/tedium.png?branch=master)](https://travis-ci.org/cantierecreativo/tedium)
[![Coverage Status](https://coveralls.io/repos/cantierecreativo/tedium/badge.png)](https://coveralls.io/r/cantierecreativo/tedium)
[![Code Climate](https://codeclimate.com/github/cantierecreativo/tedium.png)](https://codeclimate.com/github/cantierecreativo/tedium)

Remove the tedium of formulaic form filling with [SitePrism](https://github.com/natritmeyer/site_prism) and [Capybara](https://github.com/jnicklas/capybara). Tedium allows you to specify a set of fields and actions to be performed rather than procedurally calling Capybara’s DSL methods on SitePrism elements.

## Usage

```ruby
class SignInPage < SitePrism::Page
  fields :name, :email, :terms_of_service
  submit_button

  submission :sign_in
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

## SitePrism DSL

### field

```ruby
field(name, attribute_name = name)
```

Declares the presence of a field within the page. The selector used to find the input relies on Rails `name="model[attribute]"` attribute convention: `[name$="[attribute]"]`

If the underlying attribute name differs from the name you want to give to the page object field, provide the attribute name as the second argument.

Once a `:foobar` field is declared, the page object will define a `#foobar_field` method, which will return the corresponding Capybara node element.

### fields

```ruby
fields(*names)
```

If you need to declare multiple fields at once, you can use this batch method.

### date_field

```ruby
date_field(name, attribute_name = name)
```

Declares the presence of a `date_select` set of selects within the page. Once a `:date_of_birth` date_field is declared, the page object will define a `#date_of_birth_field` method, which will return a `Tedium::VirtualDateElement` instance. Calling `date_of_birth_field.set(Date.new)` will fill in the year, month and day selects with the correct values.

You can access to the specific year select element with `date_of_birth_field.year_element` method (the same applies also for month and day selects).

### datetime_field

```ruby
datetime_field(name, attribute_name = name)
```

Similar to `date_field`, it declares the presence of a `datetime_select` set of selects within the page.

You can access to the specific hour and minute select elements with `.hour_element` and `.minute_element` method.

### submit_button

```ruby
submit_button(role = nil)
```

Declares the presence of a submit button within the page. It can be either a `input[type=select]` or a `button`. If you pass an argument to the method (ie. `submit_button :sign_in`), the selector will be augmented with a `[role='sign-in']` filter (please note the automatic conversion in *snake-case*).

Once the submit button is declared, the page object will define a `#submit!`
method which will press the button.

### submission

```ruby
submission(name, fields = nil)
```

Declares a submission process.

Given the following page:

```ruby
class SignInPage < SitePrism::Page
  fields :name, :email, :terms_of_service
  submit_button

  submission :sign_in
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

You can explicitly change the fields used during the submission (or their order) passing an array of field names as second argument:

```ruby
class SignInPage < SitePrism::Page
  fields :name, :email, :terms_of_service
  submit_button

  submission :sign_in, %w(email name)
end
```

### action

```ruby
action(name, role = name)
```

Declares the presence of an action button/link within the page. Once a `:sign_out` action is declared, the page object will define a `#sign_out_element` method, which will return the corresponding Capybara node and a `#sign_out!` method, which will perform a click on the element.

The selector relies on a `role` attribute present in the action element (see `submit_button` for details). If the role attribute differs from the name you want to give to the page object action, provide it as a second argument.

```html
<a href="/session" data-method="delete" role="sign-out">Sign out</a>
```
```ruby
class DashboardPage < SitePrism::Page
  action :sign_out
end

page = DashboardPage.load
page.sign_out_element # => <Capybara::Node::Element ...>
page.sign_out! # clicks on the link
```

### actions

```ruby
actions(*names)
```

If you need to declare multiple actions at once, you can use this batch method.

## Changes to the Capybara node element #set method

In order to be able to fill in text inputs, selects and checkboxes using the same API, Tedium slightly extends the default `Capybara::Node::Element#set` behaviour. If the element is a select, the first option with a value or text that matches the provided value will be selected:

```html
<select>
  <option value='1'>Option 1</option>
  <option value='2'>Option 2</option>
  <option value='3'>Option 3</option>
</select>
```
```ruby
# both will select the second option
page.find_first('select').set('Option 2') 
page.find_first('select').set('2')
```

## has_record?

Every SitePrism page inherits a `:record` SitePrism dynamic element, useful in conjunction with the [Rails `div_for` helper](http://devdocs.io/rails/actionview/helpers/recordtaghelper#method-i-div_for) or [Showcase Record trait](https://github.com/stefanoverna/showcase#showcasetraitsrecord):

```erb
<%= div_for(@person, class: "foo") do %>
   <%= @person.name %>
<% end %>
```

```ruby
expect(page).to have_record(@person) # green!
```

