class HeroMapper
	def initialize(base_url, result)
		@base_url = base_url
		@result = result
	end

	def convert
		{
			type: 'hero',
			id: @result['id'],
			attributes: {
				name: @result['name'],
				real_name: @result['real_name'],
				health: @result['health'],
				armour: @result['armour'],
				shield: @result['shield'],
			},
			links: {
				self: "#{@base_url}/#{@result['id']}",
				abilities: "#{@base_url}/#{@result['id']}/abilities",
			},
		}
	end
end
