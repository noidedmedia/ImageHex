require 'scss_lint/rake_task'

namespace :scss do
  SCSSLint::RakeTask.new :lint do |t|
    t.config = 'config/scss-lint.yml'
    t.files = ['app/assets/stylesheets']
  end
end
