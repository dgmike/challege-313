class CollectionMapper
	def initialize(base_url, page, limit, result)
		@base_url = base_url
		@page = page
		@limit = limit
		@result = result
	end

	def	convert
		{
			links: links,
			data: convert_results
		}
	end

	def links
		{
			self: "#{@base_url}?page=#{@page}&limit=#{@limit}",
			next: next_page? && "#{@base_url}?page=#{@page + 1}&limit=#{@limit}",
			previous: prev_page? && "#{@base_url}?page=#{@page - 1}&limit=#{@limit}",
			first: "#{@base_url}?page=1&limit=#{@limit}",
			last: "#{@base_url}?page=#{last_page}&limit=#{@limit}",
		}
	end

	def last_page
		(@result['total'] / @limit.to_f).ceil 
	end

	def next_page?
		last_page > @page
	end

	def prev_page?
		@page > 1
	end

	def convert_results
		@result['data'].map do |item|
			{
				type: 'hero',
				id: item['id'],
				attributes: {
					name: item['name'],
					real_name: item['real_name'],
					health: item['health'],
					armour: item['armour'],
					shield: item['shield'],
				},
				links: {
					self: "#{@base_url}/#{item['id']}",
					abilities: "#{@base_url}/#{item['id']}/abilities",
				},
			}
		end
	end
end
