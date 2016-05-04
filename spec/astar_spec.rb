require 'spec_helper'

class Point
  attr_reader :x, :y

  def initialize(x,y); @x=x ; @y=y end

  def <=> (obj); 0 end
end

def build_graph(n)
  graph=Shortest::Path::Graph.new
  (0..n-1).each do |x|
    (0..n-1).each do |y|
      graph.push Point.new(x,y)
    end
  end
  (0..n*n-1).each do |i|
    graph.connect_mutually(graph[i], graph[i+1], 1,0) unless (i+1)%n == 0
    graph.connect_mutually(graph[i], graph[i+n], 1,0) unless i+1 > n*(n-1)
  end
  graph
end

describe 'AStar priority queue' do
  before(:all) do
    @queue = Shortest::Path::PriorityQueue.new
    @queue << [1, "A"]
    @queue << [3, "C"]
    @queue << [2, "B"]
  end
  specify{ expect(@queue.next).to eq("A") }
  specify{ expect(@queue.next).to eq("B") }
  specify{ expect(@queue.next).to eq("C") }
end

describe 'AStar' do
  before(:all) do
    @graph=build_graph(3)
    @p1=@graph.first ; @p2=@graph.last
    dist = heur = ->(p1,p2){ dx=p1.x-p2.x ; dy=p1.y-p2.y ; Math.sqrt(dx*dx + dy*dy) }
    @shortest=Shortest::Path.astar(dist, heur, @graph, @p1, @p2)
  end

  specify{ expect(@graph.size).to eq(9) }
  specify{ expect(@graph.edges.size).to eq(24) }
  specify{ expect(@shortest.size).to eq(5) }
  specify{ expect(@shortest[0]).to eq(@graph[0]) }
  specify{ expect(@shortest[1]).to eq(@graph[3]) }
  specify{ expect(@shortest[2]).to eq(@graph[6]) }
  specify{ expect(@shortest[3]).to eq(@graph[7]) }
  specify{ expect(@shortest[4]).to eq(@graph[8]) }
end

def astar_performance(n)
  graph = build_graph(n)
  p1 = graph.first ; p2 = graph.last
  dist = heur = ->(p1,p2){ dx=p1.x-p2.x ; dy=p1.y-p2.y ; Math.sqrt(dx*dx + dy*dy) }
  t1 = Time.now
  shortest=Shortest::Path.astar(dist, heur, graph, p1, p2)
  Time.now - t1
end

describe 'AStar performance' do
  before(:all) do
    puts ""
    k = 10
    (1..3).each do |n|
      t = astar_performance(k)
      puts "#{k}: #{t} sec"
      k = k * 2
    end
  end
  specify{ expect(true).to eq(true) }
end
