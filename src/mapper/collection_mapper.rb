class CollectionMapper
	def self.links(base_url, page, limit, total)
		{
			self: "#{base_url}?page=#{page}&limit=#{limit}",
			next: page >= (total / limit.to_f).ceil ? nil : "#{base_url}?page=#{page + 1}&limit=#{limit}",
			previous: page <= 1 ? nil : "#{base_url}?page=#{page - 1}&limit=#{limit}",
			first: "#{base_url}?page=1&limit=#{limit}",
			last: "#{base_url}?page=#{(total / limit.to_f).ceil}&limit=#{limit}",
		}
	end
end
