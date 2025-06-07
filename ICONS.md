# railsui_icon - Available Icons

## Icon Libraries

We cover the following libraries for now. More to come in the future.

### Heroicons

- **Structure:** Nested (with variants)
- **Variants:** `outline`, `solid`, `mini`, `micro`
- **Source:** [heroicons.com](https://heroicons.com)

### Boxicons

- **Structure:** Nested (with variants)
- **Variants:** `outline`, `solid`
- **Source:** [boxicons.com](https://boxicons.com)

### Solar

- **Structure:** Nested (with variants)
- **Variants:** `linear`, `outline`, `broken`, `bold`, `bold_duotone`, `line_duotone`
- **Source:** [github.com/480-Design/Solar-Icon-Set](https://github.com/480-Design/Solar-Icon-Set)

### Feather

- **Structure:** Flat (no variants)
- **Source:** [feathericons.com](https://feathericons.com/)

### Lucide

- **Structure:** Flat (no variants)
- **Source:** [lucide.dev](https://lucide.dev)

### Phosphoric

- **Structure:** Nested (with variants)
- **Variants:** `bold`, `duotone`, `fill`, `light`, `regular`, `thin`
- **Source:** [phosphoricons.com](https://phosphoricons.com/)

## Usage Examples

```erb
<!-- Basic usage (uses default library and variant) -->
<%= icon "star" %>

<!-- Specify library and variant inline -->

<%= icon "8-ball", library: :boxicons, variant: :outline %>

<%= icon "headphones", library: :feather %>

<%= icon "star", library: :heroicons, variant: :solid %>

<%= icon "chef-hat", library: :lucide %>

<%= icon "books-duotone", library: :phosphoric, variant: :duotone %>

<%= icon "star", library: :solar, variant: :linear %>

<!-- Path-based naming -->
<%= icon "heroicons/solid/star" %>
<%= icon "solar/linear/star" %>
<%= icon "outline/star" %>

<!-- With custom classes -->
<%= icon "star", class: "size-8 text-red-500" %>

<!-- Kitchen sink -->
<%= icon "star", library: :solar, variant: :bold, class: "size-12 text-purple-500 hover:scale-110" %>
```

## Finding Icon Names

### Browse the file system

```bash
# From your Rails app root
find $(bundle show railsui_icon)/lib/railsui_icon/icons -name "*.svg" | head -20
```

### Method 2: Check the source websites

- **Heroicons:** Browse at [heroicons.com](https://heroicons.com)
- **Solar:** Browse at [github.com/480-Design/Solar-Icon-Set](https://github.com/480-Design/Solar-Icon-Set)
- **Lucide:** Browse at [lucide.dev](https://lucide.dev)
- **Phosphoric:** Browse at [phosphoricons.com](https://phosphoricons.com)
- **Feather:** Browse at [feathericons.com](https://feathericons.com)
- **Boxicons:** Browse at [boxicons.com](https://boxicons.com)

## Adding Custom Icons

You can override or add icons by placing them in your Rails app:

```bash
app/assets/icons/
├── heroicons/
│   ├── outline/
│   │   └── my-custom-icon.svg
│   └── solid/
│       └── my-custom-icon.svg
├── solar/
│   └── linear/
│       └── my-solar-icon.svg
└── lucide/
    └── my-lucide-icon.svg
```

## Configuration

```ruby
# config/initializers/railsui_icon.rb
RailsuiIcon.configure do |config|
  # Required
  config.default_library = :heroicons
  config.default_variant = :outline

  # Optional
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
