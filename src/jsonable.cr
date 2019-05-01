# TODO: Write documentation for `Jsonable`
require "json"

module Jsonable
  VERSION = "0.1.0"

  macro generate_json_field_array(json, field)
      json.field {{field}} do
          json.array do
              self.{{field.id}}.each do |item|
                  item.get_collection_fields(json)
              end
          end
      end
  end

  macro get_json_field(field)
      json.field {{field}}, self.{{field.id}}
  end

  macro determine_field(field, field_type)
      {% field_type_string = field_type.stringify %}
      {% not_object_collection =
           field_type_string.includes?("Array(") &&
             !["String", "Int", "Bool", "Float", "Hash"].all? { |x| !field_type_string.includes?(x) } %}

      {% if not_object_collection %}
          get_json_field({{field}})
      {% elsif field_type_string.includes?("Array(") %}
          generate_json_field_array(json, {{field}})
      {% else %}
          get_json_field({{field}})
      {% end %}
  end

  macro get_single(json, json_fields)
      json.object do
          {% for field in json_fields %}
              {%
                @type.instance_vars.map do |instance_var|
                  if instance_var.name.stringify == field
                    field_type = instance_var.type
                  end
                end
              %}
              
              determine_field({{field}}, {{field_type}})
          {% end %}
      end
  end

  macro public_json_fields(json_fields)
      def get_json
          JSON.build do |json|
              get_single(json, {{json_fields[0]}})
          end
      end

      def get_collection_fields(json)
          {% if json_fields[1] %}
              return get_single(json, {{json_fields[1]}})
          {% end %}

          get_single(json, {{json_fields[0]}})
      end

      def self.get_json_collection(collection)
          JSON.build do |json|
              json.array do
                  collection.each do |item|
                      item.get_collection_fields(json)
                  end
              end
          end
      end
  end
end
