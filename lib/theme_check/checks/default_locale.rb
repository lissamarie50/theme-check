# frozen_string_literal: true
module ThemeCheck
  class DefaultLocale < JsonCheck
    severity :suggestion
    category :translation
    doc docs_url(__FILE__)

    def on_end
      return if @theme.default_locale_json
      #corrector block? (how can we ensure that only those who opt in to auto correct get their code autocorrected?)
      add_offense("Default translation file not found (for example locales/en.default.json)")
      @theme.create_default_locale_json
    end
  end
end
