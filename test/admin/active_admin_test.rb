require 'test_helper'

describe "Active Admin" do
  let(:all_resources) { ActiveAdmin.application.namespaces[:admin].resources }

  describe "pages count" do
    it "should be 4" do
      all_resources.count.must_equal(4)
    end
  end

  describe "resource" do
    ["Calligraph::AdminUser", "Content", "Template"].each do |resource|
      it "should contain resource - #{resource}" do
        all_resources.keys.map{|a| a.to_s}.must_include(resource)
        all_resources[resource].must_be_kind_of(ActiveAdmin::Resource)
      end
    end
  end

  describe "pages" do
    ["Dashboard"].each do |page|
      it "should contain page - #{page}" do
        all_resources.keys.map{|a| a.to_s}.must_include(page)

        # todo - need a cleaner way to test AA dsl.
        # all_resources[page].should be_kind_of(ActiveAdmin::Page)
      end
    end
  end

  describe "javascript includes" do
    it "should include javascript calligraph/make_content_editable.js" do
      ActiveAdmin.application.javascripts.must_include("calligraph/make_content_editable.js")
    end
  end

  describe "comments" do
    it "should be disabled" do
      ActiveAdmin.application.allow_comments.must_equal(false)
    end
  end
end
