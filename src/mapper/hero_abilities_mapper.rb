class HeroAbilitiesMapper
	def initialize(base_url, hero_id, result)
		@base_url = base_url
		@hero_id = hero_id
		@result = result
	end

	def convert
		{
			links: {
				self: "#{@base_url}/heroes/#{@hero_id}/abilities",
				hero: "#{@base_url}/heroes/#{@hero_id}",
				heroes: "#{@base_url}/heroes",
			},
			data: convert_data
		}
	end
	
	def convert_data
		@result.map do |item|
			{
				id: item['id'],
				attributes: {
					name: item['name'],
					description: item['description'],
					is_ultimate: item['is_ultimate'],
				},
				links: {
					self: "#{@base_url}/abilities/#{item['id']}",
					abilities: "#{@base_url}/abilities",
				}
			}
		end
	end
end
