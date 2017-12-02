require './mapper/collection_mapper'
require './mapper/hero_mapper'

class HerosCollectionMapper < CollectionMapper
	def conert_results
		@result['data'].map { |item| HeroMapper.new(@base_url, item).convert }
	end
end