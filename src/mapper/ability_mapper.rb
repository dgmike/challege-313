class AbilityMapper
	def initialize(base_url, result)
		@base_url = base_url
		@result = result
	end

	def convert
		{
			type: 'ability',
			id: @result['id'],
			attributes: {
				name: @result['name'],
				description: @result['description'],
				is_ultimate: @result['is_ultimate'],
			},
			links: {
				self: "#{@base_url}/#{@result['id']}",
				abilities: "#{@base_url}",
			},
		}
	end
end
