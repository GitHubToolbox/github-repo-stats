#
# Class level docs
#
class GithubRepoStats
    class << self
        #
        # Everything below here is private
        #

        private

        # This method smells of :reek:UtilityFunction
        def create_table
            Terminal::Table.new :headings => ['Repository', 'Organisation', 'Watchers', 'Star Gazers', 'Forks', 'Open Issues']
        end

        # This method smells of :reek:ControlParameter, :reek:LongParameterList
        def add_title(table, repo_count)
            title = "There were #{repo_count} #{plural(repo_count, 'repository', 'respositories')}"

            table.title = title
            table
        end

        def add_single_row(table, repo)
            table.add_row [repo[:repo], repo[:org], repo[:watchers], repo[:stargazers], repo[:forks], repo[:open_issues]]
            table
        end

        def add_rows(table, results)
            results.each { |repo| table = add_single_row(table, repo) }
            table
        end

        def display_table(table)
            puts table
        end
    end
end
