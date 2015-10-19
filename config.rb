###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :bower

configure :development do
  set :relative_links, true
  activate :relative_assets
  activate :livereload
end

# Build-specific configuration
configure :build do
  set :relative_links, false
  set :http_prefix, '/climatzon/'
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

summary_generator = proc do |context, rendered, *args|
  html = html_doc = Nokogiri::HTML('<article>' + rendered + '</article>')
  nodes = html.css('article > *')
  hr = html.at_css('article > hr')
  hr ? nodes.slice(0, nodes.index(hr)).to_html : nodes.first.to_html
end

helpers do
  MONTHS = %w(января февраля марта апреля мая июня июля августа сентября октября ноября декабря)

  def date(d)
    "#{d.day} #{MONTHS[d.month.to_i - 1]} #{d.year}"
  end
end

activate :blog do |blog|
  blog.name = 'news'
  blog.prefix = 'about/news'
  blog.layout = 'page'
  blog.permalink = '{year}-{month}-{day}-{title}.html'
  blog.summary_generator = summary_generator
end

activate :blog do |blog|
  blog.name = 'jobs'
  blog.prefix = 'about/jobs'
  blog.layout = 'page'
  blog.permalink = '{year}-{month}-{day}-{title}.html'
  blog.summary_generator = summary_generator
end
