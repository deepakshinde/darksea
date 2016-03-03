# DarkSea

A dark colored theme for Rails intended to be used in an admin/dashboard capacity.

## Quick Setup

If your app *is* an administration tool you can get setup quickly. Being that this is a Bootstrap theme, you will need to include Bootstrap in your `Gemfile` alongside this theme.

```ruby
# Gemfile
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'darksea', '~> 0.0'
```

The conscious choice was made not to include Bootstrap as a runtime dependency because:

1. you're likely already using it in your project
2. if you want to discontinue using this theme you won't be ripping out Bootstrap as well

Bootstrap takes [a little setting up](https://github.com/twbs/bootstrap-rubygem), if you haven't done so already.

## Setup for admin section

There are far too many ways to structure your admin section, but I'll provide a decent pattern that will probably work for a lot of folks.

### Routes

Again, the decision is up to you and how you setup your admin. This is simply something that works for me. Namespace you admin section with something like:

```ruby
# config/routes.rb
...
namespace :admin do
  resources :users
  resources :posts
end
```

Then, we create a couple helpers to determine whether we're in the admin section. And what stylesheet to serve.

```ruby
# app/helpers/application_helper.rb
def admin_section?
  request.fullpath.include? 'admin'
end

def relevant_stylesheet
  if admin_section?
    stylesheet_link_tag 'admin/admin', media:'all', 'data-turbolinks-track' => true
  else
    stylesheet_link_tag 'application', media:'all', 'data-turbolinks-track' => true
  end
end
```

This of course means you need some sort of admin manifest scss file at `app/assets/stylesheets/admin/admin.scss`.

Finally, you'll need to add the following to the `<head>` of your document:

```html.erb
<%= relevant_stylesheet %>
```

This will deliver your admin stylesheet for any route that has "admin" in the path. Not too shabby
