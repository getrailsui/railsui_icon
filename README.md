# railsui_icon

This is a standalone gem from the maker of [Rails UI](https://railsui.com) aimed at making rendering icons in Rails applications easier. Originally built for [Heroicons](https://heroicons.com/), it now supports multiple icon libraries including [Solar Icons](https://solar-icons.vercel.app/) and [Lucide Icons](https://lucide.dev/).

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

The installer creates a new initializer where you can assign some defaults. For new installations, you can choose from multiple icon libraries and their respective variants.

### Configuration

```ruby
# config/initializers/railsui_icon.rb

RailsuiIcon.configure do |config|
  # Required: Set the default icon library (:heroicons, :solar, :lucide)
  config.default_library = :heroicons

  # Required: Set the default icon variant. See all variants below:
  config.default_variant = :outline

  # Optional: Set default classes - supports both nested and flat structure for all libraries.
  config.default_class = {
    heroicons: {
      outline: "size-5 stroke-current",
      solid: "size-5 fill-current",
      mini: "size-3 fill-current",
      micro: "size-3 fill-current"
    },
    solar: {
      linear: "size-5 stroke-current",
      outline: "size-5 stroke-current",
      broken: "size-5 stroke-current",
      bold: "size-5 fill-current",
      bold_duotone: "size-5 fill-current",
      line_duotone: "size-5 stroke-current fill-current"
    },
    lucide: {
      lucide: "size-5 stroke-current"
    },
   phosphoric: {
      bold: "size-5 fill-current",
      duotone: "size-5 fill-current",
      fill: "size-5 fill-current",
      light: "size-5 stroke-current",
      regular: "size-5 stroke-current",
      thin: "size-5 stroke-current"
    }
    feather: {
      feather: "size-5 stroke-current"
    },
    boxicons: {
      outline: "size-5 stroke-current",
      solid: "size-5 fill-current"
    }
  }
end
```

### Backward Compatibility

If you're upgrading from an earlier version that only supported Heroicons, your existing configuration will continue to work without changes. The gem supports the original flat configuration structure:

```ruby
# This still works for backward compatibility
config.default_class = {
  solid: "size-5 fill-current",
  outline: "size-5 stroke-current",
  mini: "size-3 fill-current",
  micro: "size-3 fill-current"
}
```

## Usage

Render icons with the `icon` helper method:

```erb
<%= icon "star" %>
```

This renders using your configured default library and variant.

### Icon Libraries

Read more about the [available icon libraries](ICONS.md).

**Heroicons** (default)

```erb
<%= icon "star" %>
<%= icon "star", variant: :solid %>
<%= icon "star", variant: :outline %>
<%= icon "star", variant: :mini %>
<%= icon "star", variant: :micro %>
```

**Solar Icons**

This assumes you have your configured default library to be `:solar`. You can also specify the variant to avoid writing it inline like below.

```erb
<%= icon "astronomy-ufo" %>
<%= icon "astronomy-ufo", variant: :linear %>
<%= icon "astronomy-ufo", variant: :outline %>
<%= icon "astronomy-ufo", variant: :broken %>
<%= icon "astronomy-ufo", variant: :bold %>
<%= icon "astronomy-ufo", variant: :bold_duotone %>
<%= icon "astronomy-ufo", variant: :line_duotone %>
```

**Lucide Icons** (flat structure, no variants)

This assumes you have your configured default library to be `:lucide`.

```erb
<%= icon "star" %>
```

### Options

**Specify Library and Variant**

```erb
<%= icon "home", library: :heroicons, variant: :solid %>
<%= icon "user", variant: :bold %>
<%= icon "settings", library: :lucide %>
```

**Add CSS Classes**

```erb
<%= icon "star", class: "size-8 text-red-500 stroke-current" %>
```

**Disable Default Classes**

If you set default classes in your configuration, you can disable those explicitly:

```erb
<%= icon "star", disable_default_class: true %>
```

**Path-based Icon Names**

You can specify the full path in the icon name for explicit control:

```erb
<!-- Explicit library/variant/icon -->
<%= icon "heroicons/solid/star" %>
<%= icon "solar/bold/home" %>

<!-- Variant/icon (uses configured default library) -->
<%= icon "solid/star" %>
```

**Custom Icon Paths**

Additional icons can be sourced from `app/assets/images`. Pass a custom path to render those:

```erb
<!-- Resolves from app/assets/images/logo.svg -->
<%= icon "logo", custom_path: "/logo.svg" %>
```

**All Options Combined**

```erb
<%= icon "star",
    library: :solar,
    variant: :bold,
    class: "size-8 text-pink-500",
    custom_path: "/my_icons/star.svg",
    disable_default_class: true %>
```

## Icon Organization

Icons come bundled with this gem so you needn't include any additional icons in your Rails app.

**Note**: Lucide icons use a flat structure (no variant subdirectories) since they don't have multiple variants.

## Migration Guide

### From v1.x to v2.x

If you're upgrading from the original Heroicons-only version:

1. **No breaking changes**: Your existing configuration and icon calls will continue to work
2. **Optional upgrades**: You can gradually adopt the new nested configuration structure
3. **New features**: You can now use Solar and Lucide icons alongside your existing Heroicons

### Upgrading Configuration

**Before (v1.x)**:

```ruby
config.default_variant = :outline
config.default_class = {
  solid: "fill-current",
  outline: "size-5",
  mini: "size-3 fill-current",
  micro: "size-3 fill-current"
}
```

**After (v2.x)** - both formats work:

```ruby
# Option 1: Keep existing format (works as-is)
config.default_variant = :outline
config.default_class = {
  solid: "fill-current",
  outline: "size-5",
  mini: "size-3 fill-current",
  micro: "size-3 fill-current"
}

# Option 2: Upgrade to nested format (recommended for multiple libraries)
config.default_library = :heroicons
config.default_variant = :outline
config.default_class = {
  heroicons: {
    solid: "fill-current",
    outline: "size-5",
    mini: "size-3 fill-current",
    micro: "size-3 fill-current"
  }
}
```

## Bugs

Spot something off? Open an issue on the [GitHub repo](https://github.com/getrailsui/railsui_icon). PRs welcomed!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Rails UI

Build Ruby on Rails apps faster than ever with [Rails UI](https://railsui.com).

Rails UI features professionally designed components and templates for Ruby on Rails. Leverage breath-taking UI to fast-track your next idea.
