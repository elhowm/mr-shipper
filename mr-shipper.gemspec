# frozen_string_literal: true

Gem::Specification.new do |specs|
  specs.name        = 'mr-shipper'
  specs.version     = '0.1.1'
  specs.date        = '2023-04-12'
  specs.summary     = 'Docker shipping'
  specs.description = 'The simple way to deploy docker-compose based apps'
  specs.authors     = ['Rostyslav Safonov']
  specs.email       = 'elhowm@gmail.com'
  specs.homepage    = 'https://rubygemspecs.org/gems/mr-shipper'
  specs.license     = 'MIT'
  specs.metadata    = {
    'source_code_uri' => 'https://github.com/elhowm/mr-shipper',
    'documentation_uri' => 'https://github.com/elhowm/mr-shipper'
  }

  specs.files = %w[
    lib/shipper.rb
    lib/shipper/config.rb
    lib/shipper/deploy.rb
    lib/shipper/executor.rb
    lib/shipper/host.rb
    lib/shipper/logger.rb
    lib/shipper/run.rb
    lib/shipper/service.rb
  ]
  specs.executables << 'ship'

  specs.add_dependency 'colorize', '~> 0.8'
  specs.add_dependency 'net-ssh', '~> 7.1'
end
