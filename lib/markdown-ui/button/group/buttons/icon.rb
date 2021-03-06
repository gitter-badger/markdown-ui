module MarkdownUI::Button
  module Group
    module Buttons
      class Icon
        def initialize(element, content)
          @element = element
          @content = content
        end

        def render
          klass = "ui #{@element} icon buttons"
          content = @content.strip

          MarkdownUI::StandardTag.new(content, klass).render
        end
      end
    end
  end
end