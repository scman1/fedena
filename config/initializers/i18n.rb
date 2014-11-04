#encoding: utf-8
if File.exists?(File.expand_path("./config/locale_settings.yml"))
  locale_settings = YAML::load(File.open(File.expand_path("./config/locale_settings.yml")))
  AVAILABLE_LANGUAGES = (locale_settings['available'].length > 0) ? locale_settings['available'] : { :en => 'English' }
  I18n.default_locale = (AVAILABLE_LANGUAGES.include?(locale_settings['default'])) ? locale_settings['default'] : AVAILABLE_LANGUAGES.keys[0].to_s
  LANGUAGES = (locale_settings['available'].length > 0) ? locale_settings['available'] : { :en => 'English' } 
  RTL_LANGUAGES = locale_settings['rtl']
else  
  I18n.default_locale = :en
  LANGUAGES = [
    ['English', 'en']
  ]
  RTL_LANGUAGES = []
end
