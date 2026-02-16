module ApplicationHelper
	def source_name
      'Rare Books'
    end

	def render_search_bar(params: nil, q: nil, search_field: nil)
		render 'shared/search_bar', search_params: params || {}
	end

	def advanced_search_path
		search_action_url(action: 'advanced_search')
	end

	def container_classes
		'container-fluid'
	end

	def render_document_main_content_partial(document = nil)
		render 'catalog/document', document: (document || @document), document_counter: 0
	end

	def render_document_sidebar_partial(document = nil)
		render 'catalog/document_sidebar', document: (document || @document)
	end
end
