$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), "lib")

require 'relayapi'

map "/" do
  run RelayAPI::Web
end

RelayAPI::API.versions.each do |version|
  map version['path'] do
    run version['class']
  end
end
