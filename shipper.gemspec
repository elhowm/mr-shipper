# frozen_string_literal: true

Gem::Specification.new do |specs|
  specs.name        = 'mr-shipper'
  specs.version     = '0.0.1'
  specs.date        = '2019-06-19'
  specs.summary     = 'Docker shipping'
  specs.description = 'The simple way to deploy docker-compose based apps'
  specs.authors     = ['Rostyslav Safonov']
  specs.email       = 'elhowm@gmail.com'
  specs.homepage    = 'https://rubygemspecs.org/gems/mr-shipper'
  specs.license     = 'MIT'

  specs.files = %w[
    lib/shipper.rb
    lib/shipper/config.rb
    lib/shipper/deploy.rb
    lib/shipper/executor.rb
    lib/shipper/host.rb
    lib/shipper/logger.rb
    lib/shipper/service.rb
  ]
  specs.executables << 'ship'

  specs.add_dependency 'net-ssh', '5.1'
  specs.add_dependency 'colorize', '0.8.1'
end
