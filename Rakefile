namespace :dummy do
  task :start do
    exec "cd spec/dummy && RAILS_ENV=production bundle exec rake db:reset && bundle exec thin start -C config/thin.yml"
  end

  task :stop do
    exec "cd spec/dummy && bundle exec thin stop -C config/thin.yml"
  end
end

task :rspec do
  exec "bundle exec rspec"
end

task :spec do
  exec [
    'cd spec/dummy',
    'RAILS_ENV=production bundle exec rake db:reset',
    'bundle exec thin start -C config/thin.yml',
    'cd -',
    'bundle exec rspec',
    'cd spec/dummy',
    'bundle exec thin stop -C config/thin.yml',
    'cd -'
  ].join(' && ')
end

# task :spec => ['dummy:start', 'rspec', 'dummy:stop']
