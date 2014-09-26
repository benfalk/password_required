## PasswordRequired

[![Gem Version](https://badge.fury.io/rb/password_required.svg)](http://badge.fury.io/rb/password_required)
[![Build Status](https://travis-ci.org/benfalk/password_required.svg?branch=master)](https://travis-ci.org/benfalk/password_required)
[![Code Climate](https://codeclimate.com/github/benfalk/password_required/badges/gpa.svg)](https://codeclimate.com/github/benfalk/password_required)
[![Coverage Status](https://img.shields.io/coveralls/benfalk/password_required.svg)](https://coveralls.io/r/benfalk/password_required)
[![Dependency Status](https://gemnasium.com/benfalk/password_required.svg)](https://gemnasium.com/benfalk/password_required)
[![Inline docs](http://inch-ci.org/github/benfalk/password_required.svg?branch=master)](http://inch-ci.org/github/benfalk/password_required)

### About

Used to password protect sensitive actions.  This was inspired by the need to
follow the same pattern Github uses when adding a new key to your account.  The
goal of PasswordRequired is to make this pattern easy and flexible without
requiring additional rails libraries.

### Usage Example

```ruby
# In your gemfile
gem 'password_required'
```

```ruby
# In your controller
class WidgetsController < ApplicationController
  include PasswordRequired::ControllerConcern

  password_required for: [:create, :update, :destroy],
                    with: ->(password) { password == 'roflcopters' },
                    if: :request_ip_untrusted?

  # ...
end
```

### password_required options

* `for:` (Required) An array of methods you want to protect

* `with:` (Optional) lambda that receives the password given OR a symbol of a
method to call.  If either returns a truthy result the action will be allowed.
You may optionally define a method `password_correct?` that will be used for
all password protected actions.

* `if:` (Optional) lambda or method name that determines if a request needs to
be password protected.  Always true by default.  Useful if there are some times
you do not need to prompt for a password.  You optionally define a method
`password_required?` on the controller that will be called for all password
protected actions.

### Current Limitations and Issues

* Only POST type actions are supported DELETE, POST, PUT
* ~~Only designed and tested with rails 4.1~~
* Works for rails >= 4.0.0

### FAQ

Q: "What if I don't like the idea of magical callbacks?"

A: No problem, you'll need to define the following methods in your controller

* `password_correct?` (hint) `password_given` is the password from the request
* `password_required?` (optional) always true by default

In the controller actions you want to password protect: `guard_with_password!`

```ruby
def destroy
  guard_with_password!
  # ...
end
```

This project rocks and uses MIT-LICENSE.
