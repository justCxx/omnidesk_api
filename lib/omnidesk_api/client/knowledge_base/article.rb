module OmnideskApi
  class Client
    module KnowledgeBase
      module Article
        def kb_articles(options = {})
          get 'kb_article.json', options
        end

        def kb_article(kb_article_id, options = {})
          get "kb_article/#{kb_article_id}", options
        end

        def create_kb_article(options = {})
          post 'kb_article.json', options
        end

        def update_kb_article(kb_article_id, options = {})
          put "kb_article/#{kb_article_id}.json", options
        end

        def enable_kb_article(kb_article_id, options = {})
          put "kb_article/#{kb_article_id}/enable.json", options
        end

        def disable_kb_article(kb_article_id, options = {})
          put "kb_article/#{kb_article_id}/disable.json", options
        end

        def moveup_kb_article(kb_article_id, options = {})
          put "kb_article/#{kb_article_id}/moveup.json", options
        end

        def movedown_kb_article(kb_article_id, options = {})
          put "kb_article/#{kb_article_id}/movedown.json", options
        end

        def delete_kb_article(user_id, options = {})
          delete "kb_article/#{user_id}.json", options
        end
      end
    end
  end
end
