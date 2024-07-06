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

The installer creates a new initializer where you can set some defaults.

If no defaults are set, the fallback default variant will be `:outline` with no default classes rendered.

```ruby
# config/initializers/railsui_icon.rb

RailsuiIcon.configure do |config|
  # Set the default icon variant (:solid, :outline, :mini, :micro)
  config.default_variant = :outline

  # Optionally set default classes that apply to every icon with the given variant.
  # Make sure you update your Tailwind config if this is enabled.
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

Optionally set a `default_variant` and `default_class` which dictate how icons will render. If you set a default class make sure you update your `tailwind.config.js` file or configuration to accomodate the `railsui_icon.rb` initializer in the content array.

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

If a custom path is passed the helper resolves to `app/assets/` allowing you to render any icon.

- An icon name is still required.
- You will need to supply the appropriate file suffix in this scenario. i.e. `.svg`

```erb
<%= icon "logo", custom_path: "/images/logo.svg" %>
```

**The kitchen sink**

```erb
<%= icon "star", variant: :micro, class: "size-3 fill-current text-pink-500", custom_path: "/custom_icons/star.svg", disable_default_class: true %>
```

## Bugs

Spot something off? Open an issue on the [GitHub repo](https://github.com/getrailsui/railsui_icon). PRs welcomed!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Rails UI

Build Ruby on Rails apps faster than ever with [Rails UI](https://railsui.com).

Rails UI features professionally designed components and templates for Ruby on Rails. Leverage breath-taking UI to fast-track your next idea.
