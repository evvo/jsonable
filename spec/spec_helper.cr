require "spec"
require "../src/jsonable"

class Dummy
  include Jsonable
  getter field_included : String = "included"
  getter field_not_included : String = "not_included"
  getter field_included_for_collection : String = "field_included_for_collection"
  public_json_fields [["field_included"], ["field_included_for_collection"]]
end

class AnotherDummy
  include Jsonable
  public_json_fields [["dummies"], ["dummies"]]
  getter dummies = [] of Dummy
  setter dummies
end

class ClassWthOnlySingle
  include Jsonable
  getter test_field = "test_field"
  public_json_fields [["test_field"]]
end

class ClassWthOnlyArrayField
  include Jsonable
  getter test_field_array = ["string1", "string2"]
  public_json_fields [["test_field_array"]]
end

class SomethingParent
  include Jsonable
  getter test_field_array_parent = ["string1", "string2"]
  public_json_fields [["test_field_array_parent"]]
end

class Something < SomethingParent
  include Jsonable
  getter test_field_array_child = ["string1", "string2"]
  public_json_fields [["test_field_array_child"]]
end

class SomethingReuse < SomethingParent
end

class SomethingWithNil
  include Jsonable
  getter test_field_array = ["string1", nil]
  public_json_fields [["test_field_array"]]
end
