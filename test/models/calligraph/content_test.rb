require 'test_helper'

describe Calligraph::Content do
  let(:template) { FactoryGirl.create(:template) }

  it "should create a content page with given template" do
    content = Calligraph::Content.new(data: "{}", content_template_type: "Calligraph::Template", content_template_id: template.id, path: "/some-path", title: "some-title")
    content.save!
    content.id.should_not be nil
  end

  it "should populate error when path is not defined" do
    content = FactoryGirl.build(:content, {data: "{}", content_template_type: "Calligraph::Template", content_template_id: template.id, path: nil, title: "some-title"})
    content.should_not be_valid
    content.should have_at_least(1).errors_on(:path)
  end

  it "should populate error when path is already used" do
    FactoryGirl.create(:content, {data: "{}", content_template_type: "Calligraph::Template", content_template_id: template.id, path: "/some-path", title: "some-title"})
    content = FactoryGirl.build(:content, {data: "{}", content_template_type: "Calligraph::Template", content_template_id: template.id, path: "/some-path", title: "some-title-1"})
    content.should_not be_valid
    content.should have_at_least(1).errors_on(:path)
  end

  it "should populate error if template is nil" do
    content = FactoryGirl.build(:content, {data: "{}", content_template_type: "Calligraph::Template", content_template_id: nil, path: "/some-path", title: "some-title-1"})
    content.should_not be_valid
    content.should have_at_least(1).errors_on(:content_template)
  end

  it "should populat error if json data is invalid" do
    content = FactoryGirl.build(:content, {data: "{", content_template_type: "Calligraph::Template", content_template_id: template.id, path: "/some-path", title: "some-title-1"})
    content.should_not be_valid
    content.should have_at_least(1).errors_on(:data)
  end

  it "should populate error if data is not present" do
    content = FactoryGirl.build(:content, {data: nil, content_template_type: "Calligraph::Template", content_template_id: template.id, path: "/some-path", title: "some-title-1"})
    content.should_not be_valid
    content.should have_at_least(1).errors_on(:data)
  end

  it "should store meta tags with each content page / action" do
    content = FactoryGirl.create(:content, meta_tags: {title: "Title", keywords: "Site, Calligraph", separator: "-", nofollow: true}, path: "/some-path")
    content.meta_tags.should == {title: "Title", keywords: "Site, Calligraph", separator: "-", nofollow: true}
    content.meta_tags[:title].should == "Title"
  end
  # test "the truth" do
  #   assert true
  # end
end
