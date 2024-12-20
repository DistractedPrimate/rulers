# frozen_string_literal: true

require_relative "rulers/version"
require_relative "rulers/array"
require_relative 'rulers/routing'

module Rulers
  class Application 
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, { "Content-Type" => "text/html" }, []]
      end

      if env['PATH_INFO'] == '/'
        return [302, {'Location' =>"http://google.com"}, [] ]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      status_code = 200
      begin
        text = controller.send(act)
      rescue StandardError => e
        status_code = 500
        text = "An error occured: #{e.message}"
      ensure
        return [status_code, { "Content-Type" => "text/html" }, [text]]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
