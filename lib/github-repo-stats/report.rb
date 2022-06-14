#
# Class level docs
#
class GithubRepoStats
    class << self
        #
        # Everything below here is private
        #

        private

        #
        # This method smells of :reek:LongParameterList, :reek:DuplicateMethodCall
        #
        def draw_report(results, repo_count)
            table = create_table
            table = add_title(table, repo_count)
            table = add_rows(table, results)
            display_table(table)
        end
    end
end
