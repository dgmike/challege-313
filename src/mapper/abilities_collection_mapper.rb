require './mapper/collection_mapper'
require './mapper/ability_mapper'

class AbilitiesCollectionMapper < CollectionMapper
	def convert_results
		@result['data'].map { |item| AbilityMapper.new(@base_url, item).convert }
	end
end