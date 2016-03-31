# frozen_string_literal: true
namespace :icons do
  task :compile do
    puts "Compiling icons..."
    puts `fontcustom compile`
  end
end
