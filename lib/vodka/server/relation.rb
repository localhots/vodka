module Vodka
  module Server
    class Relation
      attr_accessor :klass, :relation, :params, :data, :metadata

      def initialize(klass, params)
        @klass = klass
        @relation = klass
        @params = params
        @data = []
        @metadata = {}

        convert!
      end

    private

      def convert!
        apply_where_conditions!
        apply_group_conditions!
        apply_having_conditions!
        apply_order_conditions!
        apply_limit_condition!
        apply_offset_condition!
        apply_pagination!

        if params.has_key?(:her_special_count)
          @data = [relation.count]
        elsif relation == klass
          @data = relation.all
        elsif relation.respond_to?(:to_a)
          @data = relation.to_a
        end
      end

      def apply!(method, *args)
        @relation = @relation.send(method, *args) if @relation.respond_to?(method)
      end

      def apply_where_conditions!
        return unless params.has_key?(:her_special_where)

        MultiJson.load(params[:her_special_where]).each do |condition|
          condition.is_a?(Hash) ? apply!(:where, condition) : apply!(:where, *condition)
        end
      end

      def apply_group_conditions!
        return unless params.has_key?(:her_special_group)

        MultiJson.load(params[:her_special_group]).each do |condition|
          if relation.respond_to?(:group)
            apply!(:group, condition)
          elsif relation.respond_to?(:group_by)
            apply!(:group_by, condition)
          end
        end
      end

      def apply_having_conditions!
        return unless params.has_key?(:her_special_having)

        MultiJson.load(params[:her_special_having]).each do |condition|
          apply!(:having, condition)
        end
      end

      def apply_order_conditions!
        return unless params.has_key?(:her_special_order)

        MultiJson.load(params[:her_special_order]).each do |condition|
          apply!(:order, condition)
        end
      end

      def apply_limit_condition!
        apply!(:limit, params[:her_special_limit].to_i) if params.has_key?(:her_special_limit)
      end

      def apply_offset_condition!
        apply!(:offset, params[:her_special_offset].to_i) if params.has_key?(:her_special_offset)
      end

      def apply_pagination!
        return unless params.has_key?(:her_special_paginate)

        per_page = params[:her_special_limit].to_i
        current_page = params[:her_special_offset].to_i / per_page + 1
        total_entries = relation.count

        @metadata = { current_page: current_page, per_page: per_page, total_entries: total_entries }
      end
    end
  end
end
