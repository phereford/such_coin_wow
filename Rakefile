require File.expand_path('../config/application', __FILE__)

SuchCoinWow::Application.load_tasks

if Rails.env.development? || Rails.env.test?
  desc 'Run all specs except factory specs'
  RSpec::Core::RakeTask.new(:specs_without_factory_specs) do |t|
    t.rspec_opts = '--tag ~factories'
  end

  desc 'Run factory specs.'
  RSpec::Core::RakeTask.new(:factory_specs) do |t|
    t.pattern = './spec/factories_spec.rb'
  end

  desc 'Run integration tests.'
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = './spec/features/**/*_spec.rb'
    t.rspec_opts = %w(-fs -c)
  end
end

desc 'Run rails_best_practices output'
task :rbp do
  exec "rails_best_practices -f html #{Rails.root}"
end

task(:default).clear
task default: [:factory_specs, :specs_without_factory_specs, :integration]
