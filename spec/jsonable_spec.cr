require "./spec_helper"

describe Jsonable do
  # TODO: Write tests

  it "Returns the proper json fields" do
    dummy = Dummy.new
    dummy.get_json.should eq({field_included: "included"}.to_json)
  end

  it "Returns the proper json fields for collection" do
    dummy = Dummy.new
    Dummy.get_json_collection([dummy]).should eq(
      [{field_included_for_collection: "field_included_for_collection"}].to_json
    )
  end

  it "Parses related objects fields" do
    anotherDummy = AnotherDummy.new
    dummy = Dummy.new
    anotherDummy.dummies = [
      dummy,
    ]

    anotherDummy.get_json.should eq({
      dummies: [
        {field_included_for_collection: "field_included_for_collection"},
      ],
    }.to_json)
  end

  it "Uses the single field config if there is no multiple fields defined" do
    dummy = ClassWthOnlySingle.new

    ClassWthOnlySingle.get_json_collection([dummy]).should eq([
      {test_field: "test_field"},
    ].to_json)
  end

  it "Can parse arrays" do
    dummy = ClassWthOnlyArrayField.new

    dummy.get_json.should eq({
      test_field_array: ["string1", "string2"],
    }.to_json)
  end

  it "Can parse arrays for collections" do
    dummy = ClassWthOnlyArrayField.new

    ClassWthOnlyArrayField.get_json_collection([dummy]).should eq([
      {test_field_array: ["string1", "string2"]},
    ].to_json)
  end

  it "Child classes fields overrides the parent class fields" do
    dummy = Something.new

    dummy.get_json.should eq({
      test_field_array_child: ["string1", "string2"],
    }.to_json)
  end

  it "Child classes can reuse the parent fields" do
    dummy = SomethingReuse.new

    dummy.get_json.should eq({
      test_field_array_parent: ["string1", "string2"],
    }.to_json)
  end

  it "Can parse arrays with null" do
    dummy = SomethingWithNil.new

    dummy.get_json.should eq({
      test_field_array: ["string1", nil],
    }.to_json)
  end

  it "Can parse collections with arrays with null" do
    dummy = SomethingWithNil.new

    SomethingWithNil.get_json_collection([dummy]).should eq([{
      test_field_array: ["string1", nil],
    }].to_json)
  end
end
