name             "openssl"
maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Provides a library with a method for generating secure random passwords."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

recipe "openssl", "Installs the certificate_authority RubyGem."

# Depend on chef_gem for versions prior to Chef 11.
#unless node['chef_packages']['chef']['version'].match('^11..*')
depends 'chef_gem'
#end
