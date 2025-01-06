require "erubis"
require "rulers/file_model"

module Rulers
    class Controller
        include Rulers::Model
        
        def initialize(env)
            @env = env
        end

        def env
            @env
        end

        def render(view, locals = {})
            file = "app/views/#{controller_name}/#{view.to_s}.html.erb"
            template = File.read(file)
            eruby = Erubis::Eruby.new(template)
            eruby.result(locals.merge({env: env}))
        end

        def controller_name
            klass = self.class
            klass = klass.to_s.gsub /Controller$/, ""
            Rulers.to_underscore klass
        end
    end
end
