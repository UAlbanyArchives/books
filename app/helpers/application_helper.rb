module ApplicationHelper
	def source_name
      'Rare Books'
    end

    # search bar is custom to arclight so we need a helper
      def render_search_bar(params: {}, q: nil, search_field: nil)
        params ||= {}
        render(Blacklight::SearchBarComponent.new(
          url: search_catalog_path,
          params: params.merge(f: (params[:f] || {}).except(:collection)),
          q: q,
          search_field: search_field,
          autocomplete_path: suggest_index_catalog_path
        ))
      end
end
