%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  config/local.yml
).each { |path| Spring.watch(path) }
