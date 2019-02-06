module Commands
  module Entities
    class RestoreEntity < Base
      attr_accessor :uid

      validates :uid, presence: true, allow_blank: false

      def aggregate_uid
        uid
      end
    end
  end
end