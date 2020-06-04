
jekyll-render-order
===================

This plugin allows specifying a custom rendering order for files in Jekyll, such as rendering first asset files allowing their inclusion in other files.

Personally, I use this plugin to render CSS and JavaScript files first, and use their hash as a cachebuster in HTML files. Without this plugin, there's no guarantee resources render before HTML and can (and in my case, did) break compilation.

Usage
-----

First, start by including the plugin in your `Gemfile`:

```
source 'https://rubygems.org'

gem 'jekyll', '~> 3.8', '>= 3.8.6'
group :jekyll_plugins do
	gem 'jekyll-render-order'
end
```

Then add the plugin to your `_config.yml` file:

```
plugins:
  - jekyll-render-order

# The value below is the default value render order, and can be omitted if you don't want to change it
# Files not matched by any of the rules below will be rendered last
render_order:
  # 1st: CSS inside assets
  - 'assets/**/*.{css,sass,scss}',
  # 2nd: JS inside assets
  - 'assets/**/*.js',
  # 3rd: CSS elsewhere
  - '*.{css,sass,scss}',
  # 4th: JS elsewhere
  - '*.js'
```
