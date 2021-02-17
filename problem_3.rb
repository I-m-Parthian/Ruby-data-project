# frozen_string_literal: true

require 'csv'
require 'gruff'

# create table from data in the file
table_of_umpires = CSV.parse(File.read('dataset/umpires.csv'), headers: true)

ipl_umpires = Hash.new(0)

table_of_umpires.each do |table_row|
  ipl_umpires[table_row['Nationality']] += 1 if table_row['Nationality'] != 'India'
end

# create a graph for the same
graph = Gruff::Bar.new
graph.title = 'Graph of Umpires of origin'
graph.spacing_factor = 0.2

ipl_umpires.each do |country, num|
  graph.data(country, num)
end

graph.write('results/problem_3_results.png')
