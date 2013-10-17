require 'navgate'
#building menu object from scratch
# NAVGATE = Navgate.new do |build|
#   build.navs = [ Navgate::Builder.new do |options|
#           options[:selection] = %w(welcome about_us gallery )
#           options[:default] = "welcome"
#           options[:controller] = 'front_page'
#         end
#   ]
# end
#
# building menu object from database fields be sure to pass it as {Model_name: field}
NAVGATE = Navgate.new do |build|
   build.navs = [ Navgate::Builder.new do |options|
                  options[:selection] = {categories: :title }
                  options[:prefix] = 'shop_category'
                  options[:controller] = %w(front_page sales payments)
                  options[:by_id] = true
                  options[:css_class] = 'nav button'
                end
  ]
end
#
#building from yaml file, look through the yaml file for an example
# NAVGATE = Navgate.new do |build|
#   build.navs = "#{Rails.root}/config/build_menu.yml"
# end