# frozen_string_literal: true

module Jekyll
	module RenderOrder
		DEFAULT_ORDER = [
			'assets/**'
		].freeze()

		def self.sort(site)
			site.pages.sort! { |a, b|
				render_order = site.config.fetch('render_order', DEFAULT_ORDER)

				a_idx = render_order.index { |x| File.fnmatch?(x, a.path) }
				b_idx = render_order.index { |x| File.fnmatch?(x, b.path) }

				if not a_idx.nil? then
					if b_idx.nil? then
						-1
					elsif a_idx != b_idx then
						a_idx - b_idx
					else
						a.path.casecmp(b.path)
					end
				elsif not b_idx.nil? then
					+1
				else
					a.path.casecmp(b.path)
				end
			}
		end
	end
end
