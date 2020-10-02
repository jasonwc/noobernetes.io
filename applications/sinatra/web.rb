# frozen_string_literal: true

require 'sinatra'

set :bind, '0.0.0.0'

# This method builds widgets! We're adding some mathematical computation
# so that it will take some time and CPU power to create a widget
def build_widget
  100.times do |i|
    100000.downto(1) do |j|
      Math.sqrt(j) * i / 0.2
    end
  end
end

get '/' do
  build_widget
  "Your widget was built by #{ENV['POD_NAME']}"
end
