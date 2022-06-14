require 'fileutils'
require 'github-lister-core'
require 'json'
require 'open3'
require 'rainbow'
require 'terminal-table'

require_relative 'github-repo-stats/function-maps'
require_relative 'github-repo-stats/report'
require_relative 'github-repo-stats/repos'
require_relative 'github-repo-stats/table'
require_relative 'github-repo-stats/utils'
require_relative 'github-repo-stats/version'
require_relative 'github-repo-stats/wrapper'

#
# Class level docs
#
class GithubRepoStats
    class << self
        #
        # Do something ...
        #
        def get_stats(options = {})
            repos = get_repo_list(options)

            results, repo_count = process_results(repos, options)
            draw_report(results, repo_count)
        end
    end
end

#
# Add an alias because the name is long
#
GRS = GithubRepoStats
