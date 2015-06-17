require 'bundler/setup'
require 'riot'
require 'yaml'
require 'robot_sweatshop/config'

`sweatshop start`
`sweatshop stop`

PACKAGES_PATH = '.test_download_path'
SWEATSHOP_SCRIPTS_PATH = File.expand_path '.robot_sweatshop/scripts'

def clean_up_paths
  FileUtils.rm_rf [PACKAGES_PATH, '.robot_sweatshop']
end
