require 'kramdown'

module HiThere
  class RenderEmail
    def initialize(email)
      @email = email 
    end

    def perform
      render_markdown
    end

    private

    def render_markdown
      ::Kramdown::Document.new(@email.body).to_html
    end

    attr_reader :email
  end
end