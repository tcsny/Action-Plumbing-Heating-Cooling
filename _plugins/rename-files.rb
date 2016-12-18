require "front_matter_parser"

Jekyll::Hooks.register :site, :pre_render do |site|
	# code to call after Jekyll writes the site
	products = RenameFiles::Products.new(site)
end

module RenameFiles

	class Products
		def initialize(site)
			@products_dir = "#{site.in_source_dir}/_products"
			rename_products
		end

		private

		def rename_products
			Dir[@products_dir+'/*'].each do |file|
				parsed = FrontMatterParser.parse_file(file)
				title = parsed['title'].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
				File.rename file, @products_dir+"/#{title}.md" unless title.nil?
			end
		end

	end

end
