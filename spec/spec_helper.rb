require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'webrat_scraper'

require 'fakeweb'

def open_fixture(fakeweb_fixture_name)
  open(File.join(File.dirname(__FILE__), 'fakeweb_fixtures', fakeweb_fixture_name.to_s)).read
end