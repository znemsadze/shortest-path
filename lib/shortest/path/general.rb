module Shortest
  module Path
    class Edge
      attr_accessor :src, :dst, :length

      def initialize(src, dest, length)
        @src=src
        @dst=dst
        @length=length
      end
    end

    class Graph
      attr_reader :edges

      def initialize
        @edges=[]
      end

      def connect(src, dst, length)
        raise ArgumentException, "No such vertex: #{src}" unless self.include?(src)
        raise ArgumentException, "No such vertex: #{dst}" unless self.include?(dst)
        @edges.push Edge.new(src, dst, length)
      end

      def connect_mutually(vertex1, vertex2, length)
        self.connect vertex1, vertex2, length
        self.connect vertex2, vertex1, length
      end

      def neighbors(vertex)
        neighbors = []
        @edges.each do |edge|
          neighbors.push edge.dst if edge.src == vertex
        end
        return neighbors.uniq
      end
    end
  end
end