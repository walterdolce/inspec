# frozen_string_literal: true

module Inspec
  module Utils
    #
    # Inspec::Utils::JsonProfileSummary takes in certain information to identify a
    # profile and then produces a JSON-formatted summary of that profile. It can
    # return the results to STDOUT or a file. It is currently used in several
    # places in the CLI such as `json`, `archive` and `artifact`.
    #
    #
    module JsonProfileSummary
      def self.produce_json(info:, write_directory: "", suppress_output: false, logger:)
        @logger = logger || Logger.new
        # add in inspec version
        info[:generator] = {
          name: "inspec",
          version: Inspec::VERSION,
        }
        if write_directory.empty?
          puts JSON.dump(info)
        else
          unless suppress_output
            if File.exist? dst
              @logger.info "----> updating #{dst}"
            else
              @logger.info "----> creating #{dst}"
            end
          end
          fdst = File.expand_path(write_directory)
          File.write(fdst, JSON.dump(info))
        end
      end
    end
  end
end
