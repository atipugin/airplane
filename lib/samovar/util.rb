module Samovar
  module Util
    def extract_object_type(object)
      case object
      when Class then object.name
      when NilClass then nil
      else object.class.name
      end
    end

    def extract_object_id(object)
      case object
      when Class, NilClass then nil
      else object.respond_to?(:id) ? object.id : object.hash
      end
    end

    module_function :extract_object_type, :extract_object_id
  end
end
