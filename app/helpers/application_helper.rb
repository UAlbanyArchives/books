module ApplicationHelper
	def source_name
      'Rare Books'
    end

	def render_search_bar(params: nil, q: nil, search_field: nil)
		# Fall back to the current search state so query/facets persist when the
    	# user does not explicitly pass params/q.
    	params = search_state.params_for_search if params.blank?
    	q = q.presence || params[:q]
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
