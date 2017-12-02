class RequestFilter
	def self.pagination_params(params_page, params_limit, custom_opts = {})
		default_opts = { limit_max: 500, limit_default: 10 }
		opts = default_opts.merge custom_opts

		page = params_page || '1'
		page = 1 if page =~ /\D/
		page = 1 if page.to_i < 1

		limit = params_limit || '1'
		limit = opts[:limit_default] if limit =~ /\D/
		limit = opts[:limit_default] if limit.to_i < 1
		limit = opts[:limit_max] if limit.to_i > opts[:limit_max]

		[page.to_i, limit.to_i]
	end
end
