module Darksea
  class << self
    def load!
      register_darksea_engine
    end

    # Paths
    def gem_path
      @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
    end

    def stylesheets_path
      File.join assets_path, 'stylesheets'
    end

    def javascripts_path
      File.join assets_path, 'javascripts'
    end

    def assets_path
      @assets_path ||= File.join gem_path, 'assets'
    end

    private

    def register_darksea_engine
      require 'darksea/engine'
    end
  end
end

Darksea.load!
