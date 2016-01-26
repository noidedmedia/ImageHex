require 'redcarpet'

module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  # rubocop:disable LineLength
  def self.call(template)
    compiled_source = erb.call(template)
    "Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true).render(begin;#{compiled_source};end).html_safe"
  end
  # rubocop:enable LineLength
end

ActionView::Template.register_template_handler :md, MarkdownHandler
