module Calligraph
  class Engine < ::Rails::Engine
    isolate_namespace Calligraph
    initializer :calligraph do
      admin_load_path = File.join(Calligraph::Engine.root, "lib", "admin")
      ActiveAdmin.application.load_paths += [admin_load_path]
    end
  end
end
