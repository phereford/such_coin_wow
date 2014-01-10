namespace :such_coin_wow do
  require 'highline/import'

  desc 'Setup task'
  task install: [ :setup_db, :create_user, :seed_db ]

  task :setup_db do
    say('Creating the database')
    system('foreman run rake db:create')

    say('Migrating the database')
    system('foreman run rake db:migrate')

    say('Installing Dependencies from bower')
    system('foreman run rake bower:install')

    say('Resolving dependencies from bower')
    system('foreman run rake bower:resolve')

    say('Running bundle install')
    system('bundle install')
  end

  task :create_user => :environment do
    email = ask('Email address: ') { |q| q.default = 'admin@admin.com' }
    password = ask('Password: ') { |q| q.echo = 'x' }
    password_confirmation = ask('Password Confirmation: ') { |q| q.echo = 'x' }
    user = User.create(
      email: email,
      password: password,
      password_confirmation: password_confirmation
    )

    say("Your user with email <%= color('#{user.email}', BOLD) %> has been created!")
  end

  task :seed_db => :environment do
    user = User.first

    coins = YAML.load_file(Rails.root.join('config', 'coins.yml'))
    coins.each do |coin|
      coin = user.coins.create(coin)
      say("<%= color('#{coin.ticker}', BOLD) %> has been created!")
    end
  end
end
