# frozen_string_literal: true
desc "Run all tests (rspec, rubocop, eslint, sass-lint)"
task :test do
  exit [
    system("node_modules/.bin/sass-lint -vq"),
    system("node_modules/.bin/eslint app"),
    system("bundle exec rubocop"),
  ].all?
end
