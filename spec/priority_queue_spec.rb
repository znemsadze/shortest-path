require 'spec_helper'

describe 'PriorityQueue' do
  before(:all) do
    @queue=Shortest::Path::PriorityQueue.new
    @queue.add_with_priority("A",1)
    @queue.add_with_priority("D",4)
    @queue.add_with_priority("C",3)
    @queue.add_with_priority("B",2)
  end

  specify{ expect(@queue).not_to be_empty }
  specify{ expect(@queue.include?("A")).to eq(true) }
  specify{ expect(@queue.pop).to eq("A") }
  specify{ expect(@queue.pop).to eq("B") }
  specify{ expect(@queue.pop).to eq("C") }
  specify{ expect(@queue.pop).to eq("D") }
  specify{ expect(@queue).to be_empty }
  specify{ expect(@queue.include?("A")).to eq(false) }
end
