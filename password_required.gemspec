$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'password_required/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'password_required'
  s.version     = PasswordRequired::VERSION
  s.authors     = ['Benjamin Falk']
  s.email       = %w(benjamin.falk@yahoo.com)
  s.homepage    = 'https://github.com/benfalk/password_required'
  s.summary     = 'Password Protection'
  s.description = 'Requires password for rails controller actions'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 4'
end
