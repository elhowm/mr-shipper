# frozen_string_literal: true
require 'gem_helper'

describe Shipper::Deploy do
  subject(:deploy) { Shipper::Deploy.new(config, services).perform }

  let(:watcher) { Shipper::TestHelpers::Watcher.instance }

  let(:config) do
    Shipper::Config.new(config_path: "#{Dir.pwd}/spec/fixtures/shipper.yml")
  end
  let(:services) { nil }

  context 'when services are not specified' do
    it 'ships all services' do
      deploy

      expect(watcher.local_log).to eq [
        'cd ./sample-fronted',
        'yarn build',
        'cd ./sample-fronted',
        'docker build . -t dude/sample-fronted --build-arg foo=bar',
        'cd ./sample-fronted',
        'docker push dude/sample-fronted',
        'cd ./sample-backend',
        'docker build . -t dude/sample-backend',
        'cd ./sample-backend',
        'docker push dude/sample-backend'
      ]
      expect(watcher.host_log).to eq [
        'cd ~/apps/sample; docker-compose pull',
        'cd ~/apps/sample; docker-compose down',
        'cd ~/apps/sample; docker-compose up -d'
      ]
    end
  end

  context 'when services specified' do
    let(:services) { ['frontend'] }

    it 'ships only specified services' do
      deploy

      expect(watcher.local_log).to eq [
        'cd ./sample-fronted',
        'yarn build',
        'cd ./sample-fronted',
        'docker build . -t dude/sample-fronted --build-arg foo=bar',
        'cd ./sample-fronted',
        'docker push dude/sample-fronted'
      ]
      expect(watcher.host_log).to eq [
        'cd ~/apps/sample; docker-compose pull',
        'cd ~/apps/sample; docker-compose down',
        'cd ~/apps/sample; docker-compose up -d'
      ]
    end
  end
end
