require 'teststrap'

context 'sweatshop-tears' do
  setup { File.expand_path "#{__dir__}/../bin/sweatshop-tears" }
  context '' do
    setup { `#{topic}` }
    denies_topic('the output').empty
  end

  context 'init' do
    setup do
      #
      `#{topic} init`
    end
    denies_topic('the output').empty
    asserts('packages are downloaded') { Dir.exist? Tears.download_path }
  end
end

# remove
# list
# show
