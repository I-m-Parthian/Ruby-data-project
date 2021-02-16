# frozen_string_literal: true

require 'csv'
require 'gruff'

# Create a table out of given fil
table_of_teams = CSV.parse(File.read('dataset/deliveries.csv'), headers: true)
hash_of_teams = Hash.new(0)

# Calculate total runs of each team
table_of_teams.each do |table_row|
  hash_of_teams[table_row['batting_team']] += table_row['total_runs'].to_i
end

# Resolve redundancy in SuperGiants runs
hash_of_teams['Rising Pune Supergiants'] += hash_of_teams['Rising Pune Supergiant']
hash_of_teams.delete('Rising Pune Supergiant')

# plot graph from the above data
graph = Gruff::Bar.new
graph.title = 'Bar chart of total scores of teams in the IPL'
graph.spacing_factor = 0.2

array_of_runs = []
hash_of_teams.each do |_key, value|
  array_of_runs.push(value)
end
# pp array_of_runs
graph.data('', array_of_runs)

# hard code the labels
graph.labels = {
  0 => 'SH',
  1 => 'RCB',
  2 => 'MI',
  3 => 'GL',
  4 => 'KKR',
  5 => 'KXP',
  6 => 'DD',
  7 => 'CSK',
  8 => 'RR',
  9 => 'DC',
  10 => 'KTK',
  11 => 'PW',
  12 => 'RPS'
}

graph.write('teamScores.png')
