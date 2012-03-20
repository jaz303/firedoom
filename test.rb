require './lib/firedoom'

world = Firedoom::World.new

world.system('Phyiscs') do |s|
  
end

world.system('Animation') do |s|
  s.inert!
end

backend = Firedoom::Backends::JavaBackend.new
backend.delete_before = true
backend.world = world
backend.output_dir = './src'
backend.root_package = 'com.onehackoranother.test'
backend.generate!