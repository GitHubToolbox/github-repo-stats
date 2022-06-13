#
# Class docs to go here
#
class GithubRepoStats
    class << self
        #
        # Everything below here is private
        #

        private

        # rubocop:disable Metrics/CyclomaticComplexity
        # This method smells of :reek:NilCheck
        def handle_required_parameters(options)
            return if get_option(options, :token)

            raise StandardError.new('Please supply a username (-u) or a token (-t)') if (flag_set?(options, :user_repos) || flag_set?(options, :org_members_repos) || flag_set?(options, :all_repos)) && get_option(options, :user).nil?

            raise StandardError.new('Please supply an organisation name (-o) or a token (-t)') if flag_set?(options, :org_repos) && get_option(options, :org).nil?
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        #
        # docs go here
        #
        def get_repo_list(options)
            handle_required_parameters(options)

            function = function_map_lookup(options)

            raise StandardError.new('Missing parameters') unless function

            JSON.parse(function_wrapper(function, options))
        end

        def filter_data(repos, options)
            results = repos.map do |hash|
                next if hash['private'] == true && flag_set?(options, :public_only)

                { :slug => hash['full_name'], :repo => hash['name'], :org => hash['owner']['login'], :watchers => hash['watchers_count'], :stargazers => hash['stargazers_count'], :forks => hash['forks'] }
            end.compact.sort_by { |repo| repo[:repo].downcase }
            results
        end

        def process_results(results, options)
            results = filter_data(results, options)
            repo_count = count_repos(results)
            [results, repo_count]
        end
    end
end
