# frozen_string_literal: true
require "test_helper"

class DefaultLocaleTest < Minitest::Test
  def test_default_locale_file
    offenses = analyze_theme(
      ThemeCheck::DefaultLocale.new,
      "locales/en.default.json" => "{}"
    )
    assert(offenses.empty?)
  end

  def test_default_file_outside_locales
    offenses = analyze_theme(
      ThemeCheck::DefaultLocale.new,
      "data/en.default.json" => "{}"
    )
    refute(offenses.empty?)
  end

  def test_creates_default_file
    fixed_theme = fix_theme_return_theme_object(
      ThemeCheck::DefaultLocale.new,
      "templates/index.liquid" => <<~END,
        <p>
          {{1 + 2}}
        </p>
      END
    )

    assert(fixed_theme.default_locale_json)
  end
end
