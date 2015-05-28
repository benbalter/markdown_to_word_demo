require 'markdown_to_word'
require 'sinatra'
require 'digest'

module MarkdownToWordServer
  class App < Sinatra::Base

    get "/" do
      render_template :index, { :error => nil }
    end

    post "/" do
      doc = MarkdownToWord.convert(params["markdown"])
      content_type 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      attachment "document-#{Time.now.strftime("%Y%m%d")}-revised-final-revised (#{rand(9)+1}).docx", :attachment
      etag doc.hash
      doc.contents
    end

    def render_template(template, locals={})
      halt erb template, :layout => :layout, :locals => locals
    end

  end
end
