# I18n.config.available_locales = :ja
# I18n.default_locale = :ja
require 'i18n'
I18n.locale # => :en
I18n.locale = :ja
I18n.locale # => :ja
require 'faker'
Faker::Config.locale # => :ja
Faker::Internet.email # => ".@.com"
