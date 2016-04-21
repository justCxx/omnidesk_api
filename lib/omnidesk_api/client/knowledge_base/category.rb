module OmnideskApi
  class Client
    module KnowledgeBase
      module Category
        def kb_categories(options = {})
          get 'kb_category.json', options
        end

        def kb_category(kb_category_id, options = {})
          get "kb_category/#{kb_category_id}", options
        end

        def create_kb_category(options = {})
          post 'kb_category.json', options
        end

        def update_kb_category(kb_category_id, options = {})
          put "kb_category/#{kb_category_id}.json", options
        end

        def enable_kb_category(kb_category_id, options = {})
          put "kb_category/#{kb_category_id}/enable.json", options
        end

        def disable_kb_category(kb_category_id, options = {})
          put "kb_category/#{kb_category_id}/disable.json", options
        end

        def moveup_kb_category(kb_category_id, options = {})
          put "kb_category/#{kb_category_id}/moveup.json", options
        end

        def movedown_kb_category(kb_category_id, options = {})
          put "kb_category/#{kb_category_id}/movedown.json", options
        end

        def delete_kb_category(kb_category_id, options = {})
          delete "kb_category/#{kb_category_id}.json", options
        end
      end
    end
  end
end
