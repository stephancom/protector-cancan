module Protector
  module CanCan
    module Resource extend ActiveSupport::Concern
      included do
        alias_method :resource_base_without_protector, :resource_base
        alias_method :resource_base, :resource_base_with_protector
        alias_method :load_collection_without_protector, :load_collection
        alias_method :load_collection, :load_collection_with_protector
        alias_method :load_collection_without_protector, :load_collection
        alias_method :load_collection, :load_collection_with_protector
      end

      def resource_base_with_protector
        resource = resource_base_without_protector

        if resource_protectable? resource
          resource.restrict!(current_ability.protector_subject)
        else
          resource
        end
      end

      def load_collection_with_protector
        resource = load_collection_without_protector

        if resource_protectable? resource
          resource.restrict!(current_ability.protector_subject)
        else
          resource
        end
      end

      def load_collection_with_protector?
        load_collection_without_protector? || resource_protectable?(resource_base)
      end

      private

      def resource_protectable?(resource)
        resource.respond_to?(:restrict!) &&
        current_ability.protector_subject?
      end
    end
  end
end
