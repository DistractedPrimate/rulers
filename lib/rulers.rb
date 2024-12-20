# frozen_string_literal: true

require_relative "rulers/version"
require_relative "rulers/array"

module Rulers
  class Application 
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, { "Content-Type" => "text/html" }, [text]]
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
end
