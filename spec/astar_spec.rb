require 'spec_helper'

class Point
  attr_reader :x, :y

  def initialize(x,y)
    @x=x ; @y=y
  end
end

def build_graph(n)
  graph=Shortest::Path::Graph.new
  (0..n-1).each do |x|
    (0..n-1).each do |y|
      graph.push Point.new(x,y)
    end
  end
  (0..n*n-1).each do |i|
    graph.connect_mutually(graph[i], graph[i+1], 1) unless (i+1)%n == 0
    graph.connect_mutually(graph[i], graph[i+n], 1) unless i+1 > n*(n-1)
  end
  graph
end

describe 'AStar' do
  before(:all) do
    @graph=build_graph(3)
    @p1=@graph[0] ; @p2=@graph[8]
    dist = heur = ->(p1,p2){ dx=p1.x-p2.x ; dy=p1.y-p2.y ; Math.sqrt(dx*dx + dy*dy) }

puts "path length is: #{Shortest::Path.astar(dist, heur, @graph, @p1, @p2).size}"

  end

  specify{ expect(@graph.size).to eq(9) }
  specify{ expect(@graph.edges.size).to eq(24) }
end
