# Rails UI - Icon

This is a standalone gem from the maker of [Rails UI](https://railsui.com) aimed at making rendering [heroicons](https://heroicons.com/) (_with more icons to come in the future_) in Rails applications easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "railsui_icon"
```

And then execute:

```bash
bundle install
```

Run the installer

```bash
rails g railsui_icon:install
```

The installer creates a new initializer where you can assign some defaults. A variant is required. Choose from `:solid`, `:outline`, `:mini`, and `:micro`.

```ruby
# config/initializers/railsui_icon.rb

RailsuiIcon.configure do |config|
  # Set the default icon variant (:solid, :outline, :mini, :micro)
  config.default_variant = :outline

  # Optionally set default classes that apply to every icon with the given variant.
  # Make sure to update your Tailwind CSS config if you enable this setting.
  # content: [
  #  "./config/initializers/railsui_icon.rb",
  # ],

  config.default_class = {
    solid: "fill-current",
    outline: "size-5",
    mini: "size-3 fill-current",
    micro: "size-3 fill-current"
  }
end
```

Optionally set a `default_variant` and `default_class` which dictate how icons will render.

The gem will attempt to update a tailwind configuration automatically if you have one at the root of your project.

If you have a tailwind configuration elsewhere in your project be sure to update your content paths to include the new initializer.

```javascript
// tailwind.config.js

module.exports = {
  content: [
    "./config/initializers/railsui_icon.rb",
    // ...
  ],
}
```

## Usage

Render icons with the `icon` helper method:

```erb
<%= icon "star" %>
```

Base rendering using the default variant of `:outline`.

### Options

**Variants**

Options: - `outline` - default, `solid`, `mini`, `micro`

Pass the `variant:` option to the icon helper with the appropriate variant in symbol form to modify with icon loads.

```erb
<%= icon "star", variant: :micro %>
<%= icon "star", variant: :mini %>
<%= icon "star", variant: :outline %>
<%= icon "star", variant: :solid %>
```

**Add CSS classes**

```erb
<%= icon "star", class: "size-8 text-red-500 stroke-current" %>
```

**Disable default classes**

If you set default classes in your configuration you can disable those explicitly in one-off scenarios that might require it.

```erb
<%= icon "star", disable_default_class: true %>
```

**Pass a custom icon path**

Additional icons can be sourced from `app/assets/images`. Pass a custom path to render those. It's assumed the icon will be the `.svg` format. The path should be relative with a leading slash.

- An icon name or nil value for the name is still required.
- The file suffix is required in this scenario.

```erb
<!-- Resolves from app/assets/images/logo.svg -->

<%= icon "logo", custom_path: "/logo.svg" %>

```

**The kitchen sink**

```erb
<%= icon "star", variant: :micro, class: "size-3 fill-current text-pink-500", custom_path: "/my_icons/star.svg", disable_default_class: true %>
```

## Bugs

Spot something off? Open an issue on the [GitHub repo](https://github.com/getrailsui/railsui_icon). PRs welcomed!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Rails UI

Build Ruby on Rails apps faster than ever with [Rails UI](https://railsui.com).

Rails UI features professionally designed components and templates for Ruby on Rails. Leverage breath-taking UI to fast-track your next idea.
