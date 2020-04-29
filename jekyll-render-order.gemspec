# frozen_string_literal: true

require './lib/jekyll-render-order/version'

Gem::Specification.new do |spec|
	spec.name          = 'jekyll-render-order'
	spec.version       = Jekyll::RenderOrder::VERSION
	spec.authors       = ['Marcos Del Sol Vives']
	spec.email         = ['marcos@orca.pet']
	spec.summary       = 'Customizes Jekyll page rendering order.'
	spec.description   = 'This plugin allows customization of the order in which Jekyll pages are rendered. Ideal to ensure assets are generated before main files.'
	spec.homepage      = 'https://github.com/socram8888/jekyll-render-order'
	spec.license       = 'ISC'

	spec.files         = `git ls-files -- lib`.split('\n')
	spec.test_files    = `git ls-files -- test`.split('\n')
	spec.require_paths = ['lib']

	spec.add_dependency 'jekyll', '>= 3.0', '<5.0'
	spec.add_development_dependency 'rake'
	spec.add_development_dependency 'minitest'
	spec.add_development_dependency 'bundler'
end
