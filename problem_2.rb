# frozen_string_literal: true

require 'csv'
require 'gruff'

# create table of data out of the given file
table_of_teams = CSV.parse(File.read('dataset/deliveries.csv'), headers: true)
rcb_batsman = Hash.new(0)

# fetch total runs of each batsman of RCB
table_of_teams.each do |table_row|
  if table_row['batting_team'] == 'Royal Challengers Bangalore'
    rcb_batsman[table_row['batsman']] += table_row['total_runs'].to_i
  end
end

# extract the data of top 10 batsman
rcb_batsman = rcb_batsman.sort_by { |_name, runs| runs }.reverse

# plot the graph
graph = Gruff::Bar.new
graph.title = 'Total runs of each Batsman of RCB'
graph.spacing_factor = 0.2

rcb_batsman[..9].each do |name, runs|
  graph.data(name, runs)
end

graph.write('results/problem_2_results.png')
