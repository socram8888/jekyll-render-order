# frozen_string_literal: true

require_relative "jekyll-render-order/sort"
require_relative "jekyll-render-order/version"

Jekyll::Hooks.register :site, :pre_render do |site, payload|
	Jekyll::RenderOrder::sort(site)
end
