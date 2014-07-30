module Shortest
  module Path
    class Edge
      attr_accessor :src, :dst, :length

      def initialize(src, dst, length)
        @src=src
        @dst=dst
        @length=length
      end
    end

    class Graph < Array
      attr_reader :edges

      def initialize
        @edges=[]
      end

      def connect(src, dst, length)
        raise "No such vertex: #{src}" unless self.include?(src)
        raise "No such vertex: #{dst}" unless self.include?(dst)
        @edges.push Edge.new(src, dst, length)
      end

      def connect_mutually(vertex1, vertex2, length)
        self.connect(vertex1, vertex2, length)
        self.connect(vertex2, vertex1, length)
      end

      def remove_edge(vertex1, vertex2)
        for_remove = @edges.select{ |e| (e.src == vertex1 && e.dst == vertex2) || (e.src == vertex2 && e.dst == vertex1) }
        for_remove.each do |edge|
          @edges.delete_at(@edges.index(edge))
        end
      end

      def neighbors(vertex)
        neighbors = []
        @edges.each{|edge| neighbors.push edge.dst if edge.src==vertex }
        neighbors.uniq
      end
    end
  end
end