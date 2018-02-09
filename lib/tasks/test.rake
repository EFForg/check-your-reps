desc "Run all tests (rspec, rubocop, eslint, sass-lint)"
task :test do
  exit [
    system("node_modules/.bin/sass-lint -vq"),
    system("node_modules/.bin/eslint app/javascript"),
    system("bundle exec rubocop"),
  ].all?
end