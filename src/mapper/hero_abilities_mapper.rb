require './mapper/ability_mapper'

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
		@result.map { |item| AbilityMapper.new("#{@base_url}/abilities", item).convert }
	end
end
