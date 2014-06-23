module Shortest
  module Path
    class PriorityQueueItem
      attr_reader :item, :priority

      def initialize(item,priority)
        @item = item ; @priority = priority
      end
    end

    class PriorityQueue
      def initialize; @heap = [] end

      def add_with_priority(object, priority)
        item = PriorityQueueItem.new(object,priority)
        @heap << item
        @heap.sort!{ |x,y| x.priority <=> y.priority }
      end

      def pop; @heap.delete_at(0).item end
      def empty?; @heap.empty? end
      def include?(object); @heap.select{|x| x.item==object}.any? end
    end
  end
end
