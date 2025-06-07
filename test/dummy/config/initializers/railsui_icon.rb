# frozen_string_literal: true

RailsuiIcon.configure do |config|
  # Set the default icon library (:heroicons, :solar, :lucide)
  config.default_library = :heroicons

  # Set the default icon variant (:solid, :outline, :mini, etc.)
  config.default_variant = :outline

  # Set default classes that apply to every icon with the given library/variant
  config.default_class = {
    heroicons: {
      solid: "size-5 fill-current",
      outline: "size-5 stroke-current",
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
    }
  }
end
