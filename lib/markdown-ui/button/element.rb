module MarkdownUI::Button
  class Element
    def initialize(element, content, klass = nil, _id = nil)
      @element = element
      @content = content
      @klass = klass
      @id = _id
    end

    def render
      element = if @element.is_a? Array
        @element
      else
        @element.split(" ")
      end

      content = @content

      klass = if @klass.nil?
        element.join(" ").strip
      else
        @klass
      end

      _id = @id

      mode = OpenStruct.new(
        :icon?      => element.grep(/icon/i).any?,
        :flag?      => element.grep(/flag/i).any?,
        :image?     => element.grep(/image/i).any?,
        :focusable? => element.grep(/focusable/i).any?,
        :animated?  => element.grep(/animated/i).any?,
        :labeled?   => element.grep(/labeled/i).any?,
        :basic?     => element.grep(/basic/i).any?
      )

      if standard_button?(mode) && element.size > 1
        MarkdownUI::Button::Custom.new(element, content, klass, _id).render
      elsif mode.icon? && mode.labeled?
        icon, label = content
        MarkdownUI::Button::LabeledIcon.new(icon, label, klass, _id).render
      elsif mode.icon? && !mode.labeled?
        MarkdownUI::Button::Icon.new(content, klass, _id).render
      elsif mode.focusable?
        MarkdownUI::Button::Focusable.new(content, klass, _id).render
      elsif mode.basic?
        MarkdownUI::Button::Basic.new(content, klass, _id).render
      elsif mode.animated?
        MarkdownUI::Button::Animated.new(content, klass, _id).render
      elsif standard_button?(mode)
        MarkdownUI::Button::Standard.new(content, klass, _id).render
      end
    end

    protected

    def standard_button?(mode)
      !mode.focusable? && !mode.animated? && !mode.icon? && !mode.labeled? && !mode.basic?
    end

  end
end