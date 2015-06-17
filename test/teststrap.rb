require 'bundler/setup'
require 'riot'
require 'robot_sweatshop/config'

PACKAGES_PATH = '.test_download_path'
SWEATSHOP_SCRIPTS_PATH = '.robot_sweatshop/scripts'

`sweatshop stop`

def clean_up_paths
  FileUtils.rm_rf [PACKAGES_PATH, '.robot_sweatshop']
end
