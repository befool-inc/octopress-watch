require "jekyll"
require "jekyll/commands/serve"

module Octopress
  module Watch
    class Commands < Octopress::Command
      COMMAND_OPTIONS = {
        "only_drafts"          => ["--only-drafts", "preview only drafts."],
        "ssl_cert"             => ["--ssl-cert [CERT]", "X.509 (SSL) certificate."],
        "host"                 => ["host", "-H", "--host [HOST]", "Host to bind to"],
        "open_url"             => ["-o", "--open-url", "Launch your site in a browser"],
        "detach"               => ["-B", "--detach",
          "Run the server in the background",],
        "ssl_key"              => ["--ssl-key [KEY]", "X.509 (SSL) Private Key."],
        "port"                 => ["-P", "--port [PORT]", "Port to listen on"],
        "show_dir_listing"     => ["--show-dir-listing",
          "Show a directory listing instead of loading your index file.",],
        "skip_initial_build"   => ["skip_initial_build", "--skip-initial-build",
          "Skips the initial site build which occurs before the server is started.",],
        "livereload"           => ["-l", "--livereload",
          "Use LiveReload to automatically refresh browsers",],
        "livereload_ignore"    => ["--livereload-ignore ignore GLOB1[,GLOB2[,...]]",
          Array,
          "Files for LiveReload to ignore. Remember to quote the values so your shell "\
          "won't expand them",],
        "livereload_min_delay" => ["--livereload-min-delay [SECONDS]",
          "Minimum reload delay",],
        "livereload_max_delay" => ["--livereload-max-delay [SECONDS]",
          "Maximum reload delay",],
        "livereload_port"      => ["--livereload-port [PORT]", Integer,
          "Port for LiveReload to listen on",],
      }.freeze

      LIVERELOAD_PORT = 35_729

      def self.init_with_program(p)
        p.command(:preview) do |c|
          c.syntax "preview [options]"
          c.version VERSION
          c.description "Preview your Octopress site."
          c.alias :p

          Jekyll::Command.add_build_options(c)
          COMMAND_OPTIONS.each do |key, val|
            c.option key, *val
          end

          c.action do |args, options|
            options["show_drafts"] = options["only_drafts"]
            options["livereload_port"] ||= LIVERELOAD_PORT
            options["serving"] = true
            options["watch"  ] = true
            Jekyll::Commands::Serve::start(options)
          end
        end
      end
    end
  end
end
