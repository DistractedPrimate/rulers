require_relative "test_helper"
require 'tempfile'

class TestApp < Rulers::Application
end

class TestController < Rulers::Controller
  def example_route
    puts "rendering example_route"
    render :example_view
  end
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods
  
  def app
    TestApp.new
  end

  def test_request
    file_path = 'app/views/test/example_view.html.erb'
    FileUtils.mkdir_p(File.dirname(file_path))
    File.open(file_path, 'w') do |file|
      file.write('<h1>Hello World!</h1>')
    end

    get "test/example_route"
    puts last_response.inspect
    assert_equal last_response.status, 200
    assert_equal last_response.body, "<h1>Hello World!</h1>"
    
    File.delete(file_path)
  end

  def test_request__redirects_to_google
    get "/"
    
    assert_equal last_response.status, 302
    assert_equal last_response.headers["Location"], "http://google.com"
  end
end
