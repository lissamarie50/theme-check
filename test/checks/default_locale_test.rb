# frozen_string_literal: true
require "test_helper"

class DefaultLocaleTest < Minitest::Test
  
  def setup
    @theme = make_theme(
      "templates/index.liquid" => <<~END,
        <p>
          {{1 + 2}}
        </p>
      END
    )
  end

  # def test_default_locale_file
  #   offenses = analyze_theme(
  #     ThemeCheck::DefaultLocale.new,
  #     "locales/en.default.json" => "{}"
  #   )
  #   assert(offenses.empty?)
  # end

  # def test_default_file_outside_locales
  #   offenses = analyze_theme(
  #     ThemeCheck::DefaultLocale.new,
  #     "data/en.default.json" => "{}"
  #   )
  #   refute(offenses.empty?)
  # end

  def test_creates_default_file
    #check to see if locales/en.default.json has been created
    # expected_sources = @theme.templates
    
    expected_sources = {
      "templates/index.liquid" => <<~END,
        {{ x }}
        {{ x }}
      END
    }
    binding.pry

    #it doesn't seem as though the fix_theme method doesn't create new files
    sources = fix_theme(
      ThemeCheck::DefaultLocale.new,
      "templates/index.liquid" => <<~END,
        {{ x }}
        {{ x }}
      END
    )

    binding.pry

    # sources.each do |path, source|
    #   assert_equal(expected_sources[path], source)
    # end
    assert(@theme.default_locale_json)
  end
end
