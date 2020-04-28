# frozen_string_literal: true

require 'minitest/autorun'
require 'jekyll/site'
require 'jekyll-render-order/sort'

class SortTest < Minitest::Test
	def test_default
		order = nil

		correct = [
			# First CSS in assets
			'assets/first/b.css',
			'assets/second/a.css',
			# Then JS files in assets
			'assets/first/a.js',
			'assets/second/b.js',
			# CSS files elsewhere
			'page/style.css',
			# JS files elsewhere
			'first.js',
			'page/script.js',
			'second.js',
			# Unmatched
			'index.md',
		]

		test_sort(order, correct)
	end

	def test_first
		order = [
			# Assets in first first
			'assets/first/*',
			# Then assets in second
			'assets/second/*',
		]
		
		correct = [
			'assets/first/a.js',
			'assets/first/b.css',

			'assets/second/a.css',
			'assets/second/b.js',

			'first.js',
			'index.md',
			'page/script.js',
			'page/style.css',
			'second.js',
		]

		test_sort(order, correct)
	end

	def test_js_first
		order = [
			# JS first
			'*.js',
		]
		
		correct = [
			'assets/first/a.js',
			'assets/second/b.js',
			'first.js',
			'page/script.js',
			'second.js',

			'assets/first/b.css',
			'assets/second/a.css',
			'index.md',
			'page/style.css',
		]

		test_sort(order, correct)
	end

	private

	def test_sort(order, correct)
		config = {
			'render_order' => order
		}

		page_mocks = correct.sort().map { |x| PageMock.new(x) }
		site = SiteMock.new(config, page_mocks)

		Jekyll::RenderOrder::sort(site)

		calculated = site.pages.map { |x| x.path }
		assert_equal(correct, calculated)
	end

	class SiteMock
		attr_reader :config, :pages

		def initialize(config, pages)
			@config = config
			@pages = pages
		end
	end

	class PageMock
		attr_reader :path

		def initialize(path)
			@path = path
		end
	end
end
