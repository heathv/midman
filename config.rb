require 'slim'

# Directories
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload do |live|
    live.livereload_css_pattern = Regexp.new('_.*\.scss')
  end
end

# pretty URLs
activate :directory_indexes

# automagically add alt tags to images
activate :automatic_alt_tags



# rebuild redirects for Netlify
after_build do |builder|
  src = File.join(config[:source],"_redirects")
  dst = File.join(config[:build_dir],"_redirects")
  builder.thor.source_paths << File.dirname(__FILE__)
  builder.thor.copy_file(src,dst)
end
