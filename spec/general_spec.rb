require 'spec_helper'

describe 'Graph' do
  before(:all) do
    @graph=Shortest::Path::Graph.new
    (1..4).each{|x| @graph.push x}
    expect(@graph.size).to eq(4)
    @graph.connect_mutually 1, 2, 10
    @graph.connect_mutually 1, 3, 10
    @graph.connect_mutually 1, 4, 10
    @graph.connect_mutually 2, 4, 10

    @first_edge=@graph.edges.first
  end

  specify{ expect(@graph.neighbors(1).size).to eq(3) }
  specify{ expect(@graph.neighbors(2).size).to eq(2) }
  specify{ expect(@graph.neighbors(3).size).to eq(1) }
  specify{ expect(@graph.neighbors(4).size).to eq(2) }

  specify{ expect(@first_edge.src).to eq(1) }
  specify{ expect(@first_edge.dst).to eq(2) }
end