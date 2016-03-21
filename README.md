# DarkSea

A dark colored theme for Rails intended to be used in an admin/dashboard capacity.

**Warning:** I'm currently working on this gem based on the Bootstrap 4 *alpha*, so stuff is probably going to be wonky. I wouldn't recommend using this yet unless you're just messing around.

## Quick Setup

If your app *is* an administration tool you can get setup quickly. Being that this is a Bootstrap theme, you will need to include Bootstrap in your `Gemfile` alongside. Go ahead and [setup Bootstrap](https://github.com/twbs/bootstrap-rubygem) before proceeding below.

```ruby
# Gemfile
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'darksea', '~> 0.0'

# Recommended complimentary gems
gem 'font-awesome-sass', '~> 4.5' # Optional. Bootstrap 4 alpha doesn't have glyphicons yet
gem 'autoprefixer-rails' # Ease some browser pain  
```

```scss
// app/assets/stylesheets/application.scss
@import "font-awesome-sprockets"; // Optional
@import "font-awesome"; // Optional
@import "darksea-variables";
@import "bootstrap";
@import "darksea";
```

```js
// app/assets/stylesheets/application.js
...
//= require bootstrap-sprockets
//= require darksea
...
```

Sandwich the bootstrap `@import` with the DarkSea variables and Bootstrap dependent stylesheets.

The conscious choice was made not to include Bootstrap as a runtime dependency because:

1. you're likely already using it in your project
2. if you want to discontinue using this theme you won't be ripping out Bootstrap as well

## Setup for admin section

There are far too many ways to structure your admin section, but I'll provide a decent pattern that will probably work for a lot of folks.

[Setup Bootstrap](https://github.com/twbs/bootstrap-rubygem) first, if you haven't already.

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

### Helpers

Then, we create a couple helpers to determine whether we're in the admin section and what stylesheet to serve.

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

def relevant_javascript
  if admin_section?
    javascript_include_tag 'admin/admin', 'data-turbolinks-track' => true
  else
    javascript_include_tag 'application', 'data-turbolinks-track' => true
  end
end

```

### Stylesheets

This of course means you need some sort of admin manifest scss file at `app/assets/stylesheets/admin/admin.scss`.

```scss
@import "font-awesome-sprockets"; // Optional
@import "font-awesome"; // Optional
@import "darksea-variables";
@import "bootstrap";
@import "darksea";

// Your own styles can go below. E.g.
@import "posts";
```

### Javascripts

Just as we did with stylesheets, we'll need to create an admin manifest for javascript. Create `app/assets/javascripts/admin.js` and make sure the following exists.

```js
// app/assets/stylesheets/admin/admin.js
...
//= require bootstrap-sprockets
//= require darksea
...
```

**Note:** I typically use `application.js` as a starting point for `admin.js` and then add what's above. You can decide whether you want to have any cross-pollination between your user-facing and admin javascripts.

### Head

Finally, you'll need to add the following to the `<head>` of your document:

```html.erb
<%= relevant_stylesheet %>
<%= relevant_javascript %>
```

This will deliver your admin stylesheet and javascript for any route that has "admin" in the path. Not too shabby.

## Customization

This theme sets up Bootstrap variables that you may want to tweak for your own needs. You can override these variables by doing the following.

## Considerations

Below are some assumptions and decisions that were made in the development of this theme. Familiarize yourself with these so you know whether this theme is okay to use in your project.

### Flexbox

TODO: Describe how we use flexbox for layout, but not the Bootstrap flexbox option... yet.
