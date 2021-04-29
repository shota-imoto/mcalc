module Locale

	class Check
		SUPPORTED_LANGUAGE = %w(en ja)

		attr_reader :locale

		def initialize(locale)
			@locale = locale
		end

		def get_supported_locale
			supported? ? locale : I18n.default_locale
		end

		def supported?
			SUPPORTED_LANGUAGE.include?(locale)
		end
	end
end