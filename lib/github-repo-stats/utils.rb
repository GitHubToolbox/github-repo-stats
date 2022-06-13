#
# Class docs to go here
#
class GithubRepoStats
    class << self
        #
        # Everything below here is private
        #

        private

        #
        # This method smells of :reek:DuplicateMethodCall
        #
        def set_colour(item, status)
            return Rainbow(item).yellow if item.downcase == 'dry run'

            case status.downcase
            when 'dry run'
                Rainbow(item).cyan
            when 'failed'
                Rainbow(item).red
            else
                Rainbow(item).green
            end
        end

        # This method smells :reek:UtilityFunction, :reek:ControlParameter
        def plural(count, singular, plural = nil)
            if count == 1
                singular.to_s
            elsif plural
                plural.to_s
            else
                "#{singular}s"
            end
        end

        # This method smells of :reek:UtilityFunction
        def count_repos(results)
            results.size
        end

        def get_option(options, name)
            options[name] if options.key?(name)
        end

        def flag_set?(options, name)
            return true if options.key?(name) && options[name] == true

            false
        end
    end
end
