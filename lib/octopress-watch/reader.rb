require "jekyll/reader"

module Jekyll
  class Reader
    def retrieve_posts(dir)
      return if outside_configured_directory?(dir)
      site.posts.docs.concat(PostReader.new(site).read_posts(dir)) unless site.only_drafts
      site.posts.docs.concat(PostReader.new(site).read_drafts(dir)) if site.show_drafts
    end
  end
end
