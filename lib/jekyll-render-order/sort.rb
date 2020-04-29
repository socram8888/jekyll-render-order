# frozen_string_literal: true

module Jekyll
	module RenderOrder
		DEFAULT_ORDER = [
			'assets/**/*.{css,sass,scss}',
			'assets/**/*.js',
			'*.{css,sass,scss}',
			'*.js',
		].freeze()

		def self.sort(site)
			render_order = site.config['render_order'] || DEFAULT_ORDER

			site.pages.sort! { |a, b|
				a_idx = render_order.index { |x| File.fnmatch?(x, a.path, File::FNM_EXTGLOB) }
				b_idx = render_order.index { |x| File.fnmatch?(x, b.path, File::FNM_EXTGLOB) }

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
