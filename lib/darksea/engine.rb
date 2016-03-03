module Darksea
  module Rails
    class Engine < ::Rails::Engine
      initializer 'darksea.assets' do |app|
        %w(stylesheets javascripts).each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end
      end
    end
  end
end
