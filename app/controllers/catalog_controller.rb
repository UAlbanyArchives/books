# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog
  include BlacklightRangeLimit::ControllerOverride


  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    #
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    # config.search_builder_class = ::SearchBuilder
    #
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response
    #
    ## Should the raw solr document endpoint (e.g. /catalog/:id/raw) be enabled
    # config.raw_endpoint.enabled = false

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      rows: 10
    }

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select'
    #config.document_solr_path = 'get'

    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    # solr field configuration for search results/index views
    config.index.title_field = 'title_tesim'
    #config.index.display_type_field = 'format'
    #config.index.thumbnail_field = 'thumbnail_path_ss'

    config.add_results_document_tool(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)

    config.add_results_collection_tool(:sort_widget)
    config.add_results_collection_tool(:per_page_widget)
    config.add_results_collection_tool(:view_type_group)

    #config.add_show_tools_partial(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)
    #config.add_show_tools_partial(:email, callback: :email_action, validator: :validate_email_params)
    #config.add_show_tools_partial(:sms, if: :render_sms_action?, callback: :sms_action, validator: :validate_sms_params)
    #config.add_show_tools_partial(:citation)

    config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark', if: :render_bookmarks_control?)
    config.add_nav_action(:search_history, partial: 'blacklight/nav/search_history')

    # solr field configuration for document/show views
    #config.show.title_field = 'title_tesim'
    #config.show.display_type_field = 'format'
    #config.show.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #
    # set :index_range to true if you want the facet pagination view to have facet prefix-based navigation
    #  (useful when user clicks "more" on a large facet and wants to navigate alphabetically across a large set of results)
    # :index_range can be an array or range of prefixes that will be used to create the navigation (note: It is case sensitive when searching values)

    
    config.add_facet_field 'collecting_area_ssim', label: 'Collecting Area'
    config.add_facet_field 'collection_ssim', label: 'Collection'
    config.add_facet_field 'date', label: 'Date', range: true
    config.add_facet_field 'language_facet_ssim', label: 'Language', limit: 10
    config.add_facet_field 'subject_ssim', label: 'Subject', limit: 10, index_range: 'A'..'Z'
    config.add_facet_field 'genre_form_ssim', label: 'Genre/Form', limit: 5, index_range: 'A'..'Z'
    config.add_facet_field 'persname_ssim', label: 'Name', limit: 5, index_range: 'A'..'Z'
    config.add_facet_field 'corpname_ssim', label: 'Corporate Name', limit: 10, index_range: 'A'..'Z'
    config.add_facet_field 'topic_term_ssim', label: 'Topic', limit: 5, index_range: 'A'..'Z'
    config.add_facet_field 'chronological_term_ssim', label: 'Chronological Term', limit: 5, index_range: 'A'..'Z'
    config.add_facet_field 'geographic_term_ssim', label: 'Geographic Term', limit: 5, index_range: 'A'..'Z'
    config.add_facet_field 'title_term_ssim', label: 'Title', limit: 5, index_range: 'A'..'Z'
    config.add_facet_field 'oversized_ssim', label: 'Oversized'
    config.add_facet_field 'format_ssim', label: 'Format'
    config.add_facet_field 'location_ssim', label: 'Location'
    config.add_facet_field 'pub_date_ssim', label: 'Publication Year', single: true
    config.add_facet_field 'author_ssim', label: 'Author', limit: 10
    config.add_facet_field 'illustrator_ssim', label: 'Illustrator', limit: 10
    config.add_facet_field 'editor_ssim', label: 'Editor', limit: 10
    config.add_facet_field 'translator_ssim', label: 'Translator', limit: 10
    config.add_facet_field 'contributor_ssim', label: 'Contributor', limit: 10

    #config.add_facet_field 'language_ssim', label: 'Language', limit: true
    config.add_facet_field 'lc_1letter_ssim', label: 'Call Number'
    config.add_facet_field 'subject_geo_ssim', label: 'Region'
    config.add_facet_field 'subject_era_ssim', label: 'Era'

    config.add_facet_field 'example_pivot_field', label: 'Pivot Field', pivot: ['format', 'language_ssim'], collapsing: true

    config.add_facet_field 'example_query_facet_field', label: 'Publish Date', :query => {
       :years_5 => { label: 'within 5 Years', fq: "pub_date_ssim:[#{Time.zone.now.year - 5 } TO *]" },
       :years_10 => { label: 'within 10 Years', fq: "pub_date_ssim:[#{Time.zone.now.year - 10 } TO *]" },
       :years_25 => { label: 'within 25 Years', fq: "pub_date_ssim:[#{Time.zone.now.year - 25 } TO *]" }
    }

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    #config.add_index_field 'title_tesim', label: 'Title'
    config.add_index_field 'title_vern_ssim', label: 'Title'
    config.add_index_field 'display_date_tesim', label: 'Date'
    config.add_index_field 'author_ssim', label: 'Author', link_to_facet: true
    config.add_index_field 'editor_ssim', label: 'Editor', link_to_facet: true
    config.add_index_field 'illustrator_ssim', label: 'Illustrator', link_to_facet: true
    config.add_index_field 'translator_ssim', label: 'Translator', link_to_facet: true
    config.add_index_field 'contributor_ssim', label: 'Contributor', link_to_facet: true
    config.add_index_field 'collecting_area_ssim', label: 'Collecting Area', link_to_facet: true
    config.add_index_field 'collection_ssim', label: 'Collection', link_to_facet: true
    config.add_index_field 'author_vern_ssim', label: 'Author'
    config.add_index_field 'format', label: 'Format', link_to_facet: true
    config.add_index_field 'language_tesim', label: 'Language'
    
    config.add_index_field 'published_ssim', label: 'Published'
    config.add_index_field 'published_vern_ssim', label: 'Published'
    config.add_index_field 'call_number_ssim', label: 'Call number', link_to_facet: true

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'display_tesim', label: 'Full Record'

    #config.add_show_field 'title_tesim', label: 'Title'
    config.add_show_field 'title_vern_ssim', label: 'Title'
    config.add_show_field 'subtitle_tsim', label: 'Subtitle'
    config.add_show_field 'subtitle_vern_ssim', label: 'Subtitle'
    config.add_show_field 'display_date_tesim', label: 'Date'
    config.add_show_field 'author_ssim', label: 'Author', link_to_facet: true
    config.add_show_field 'author_vern_ssim', label: 'Author'
    config.add_show_field 'illustrator_ssim', label: 'Illustrator'
    config.add_show_field 'editor_ssim', label: 'Editor'
    config.add_show_field 'translator_ssim', label: 'Translator'
    config.add_show_field 'contributor_ssim', label: 'Contributor'

    config.add_show_field 'collecting_area_ssim', label: 'Collecting Area', link_to_facet: true
    config.add_show_field 'collection_ssim', label: 'Collection', link_to_facet: true
    config.add_show_field 'call_number_ssim', label: 'Call Number', link_to_facet: true
    config.add_show_field 'url_fulltext_ssim', label: 'URL'
    config.add_show_field 'url_suppl_ssim', label: 'More Information'
    config.add_show_field 'language_tesim', label: 'Language'
    config.add_show_field 'format_ssim', label: 'Format', link_to_facet: true
    config.add_show_field 'oversized_ssim', label: 'Oversized', link_to_facet: true
    config.add_show_field 'location_ssim', label: 'Location', link_to_facet: true

    config.add_show_field 'publisher_ssim', label: 'Publisher', link_to_facet: true
    config.add_show_field 'published_vern_ssim', label: 'Published'
    config.add_show_field 'isbn_ssim', label: 'ISBN'
    config.add_show_field 'issn_ssim', label: 'ISSN'
    config.add_show_field 'issn_title_ssim', label: 'ISSN Title'

    config.add_show_field 'abstract_tesim', label: 'Abstract'
    config.add_show_field 'bioghist_tesim', label: 'Historical Note'
    config.add_show_field 'physical_description_tesim', label: 'Physical Description'
    config.add_show_field 'accessrestrict_tesim', label: 'Access Terms'
    config.add_show_field 'userestrict_tesim', label: 'Use Terms'
    config.add_show_field 'acqinfo_tesim', label: 'Acquisition Information'
    config.add_show_field 'custodhist_tesim', label: 'Custodial History'
    config.add_show_field 'series_tesim', label: 'Series'
    config.add_show_field 'notes_tesim', label: 'Notes'
    config.add_show_field 'contents_tesim', label: 'Contents'

    config.add_show_field 'subject_ssim', label: 'Subjects', link_to_facet: true
    config.add_show_field 'genre_form_ssim', label: 'Genres/Forms', link_to_facet: true
    config.add_show_field 'persname_ssim', label: 'Names', link_to_facet: true
    config.add_show_field 'corpname_ssim', label: 'Corporate Names', link_to_facet: true
    config.add_show_field 'topic_term_ssim', label: 'Topics', link_to_facet: true
    config.add_show_field 'chronological_term_ssim', label: 'Chronological Terms', link_to_facet: true
    config.add_show_field 'geographic_term_ssim', label: 'Geographic Terms', link_to_facet: true
    config.add_show_field 'title_term_ssim', label: 'Titles', link_to_facet: true
    #config.add_show_field solr_name("subject_ssim", :stored_searchable)

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', label: 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    #config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
    #  field.solr_parameters = {
    #    'spellcheck.dictionary': 'title',
    #    qf: '${title_qf}',
    #    pf: '${title_pf}'
    #  }
    #end

    #config.add_search_field('author') do |field|
    #  field.solr_parameters = {
    #    'spellcheck.dictionary': 'author',
    #    qf: '${author_qf}',
    #    pf: '${author_pf}'
    #  }
    #end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    #config.add_search_field('subject') do |field|
    #  field.qt = 'search'
    #  field.solr_parameters = {
    #    'spellcheck.dictionary': 'subject',
    #    qf: '${subject_qf}',
    #    pf: '${subject_pf}'
    #  }
    #end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the Solr field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case). Add the sort: option to configure a
    # custom Blacklight url parameter value separate from the Solr sort fields.
    config.add_sort_field 'date asc', label: 'date'
    config.add_sort_field 'date desc', label: 'date reversed'
    config.add_sort_field 'relevance', sort: 'score desc, pub_date_si desc, title_si asc', label: 'relevance'
    #config.add_sort_field 'year-desc', sort: 'date desc, title_si asc', label: 'date'
    config.add_sort_field 'author', sort: 'author_tesim asc, title_tesim asc', label: 'author'
    #config.add_sort_field 'title_tesim asc, date desc' label: 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggester
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
    # if the name of the solr.SuggestComponent provided in your solrconfig.xml is not the
    # default 'mySuggester', uncomment and provide it below
    # config.autocomplete_suggester = 'mySuggester'
  end
end
