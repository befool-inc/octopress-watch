require "jekyll"
require "jekyll/commands/build"

module Jekyll
  module Commands
    class Build < Command
      class << self
        alias :build_octopree_watch :build
        def build(site, options)
          site.only_drafts = options["only_drafts"]
          build_octopree_watch(site, options)
        end
      end
    end
  end
end
