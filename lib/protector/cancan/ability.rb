require 'set'

module Protector
  module CanCan
    module Ability

      def import_protector(subject)
        @protector_subject = subject
        @protector_subject_defined = true
      end

      def protector_subject
        @protector_subject
      end

      def protector_subject?
        !!@protector_subject_defined
      end
    end
  end
end
