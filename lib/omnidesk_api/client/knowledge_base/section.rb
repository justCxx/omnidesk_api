module OmnideskApi
  class Client
    module KnowledgeBase
      module Section
        def kb_sections(options = {})
          get 'kb_section.json', options
        end

        def kb_section(kb_section_id, options = {})
          get "kb_section/#{kb_section_id}", options
        end

        def create_kb_section(options = {})
          post 'kb_section.json', options
        end

        def update_kb_section(kb_section_id, options = {})
          put "kb_section/#{kb_section_id}.json", options
        end

        def enable_kb_section(kb_section_id, options = {})
          put "kb_section/#{kb_section_id}/enable.json", options
        end

        def disable_kb_section(kb_section_id, options = {})
          put "kb_section/#{kb_section_id}/disable.json", options
        end

        def moveup_kb_section(kb_section_id, options = {})
          put "kb_section/#{kb_section_id}/moveup.json", options
        end

        def movedown_kb_section(kb_section_id, options = {})
          put "kb_section/#{kb_section_id}/movedown.json", options
        end

        def delete_kb_section(user_id, options = {})
          delete "kb_section/#{user_id}.json", options
        end
      end
    end
  end
end
