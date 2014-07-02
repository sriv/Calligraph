require 'test_helper'

describe Calligraph::Content do
  let(:template) { FactoryGirl.create(:template) }

  it 'should create a content page with given template' do
    content = Calligraph::Content.new(data: '{}', content_template_type: 'Calligraph::Template', content_template_id: template.id, path: '/some-path', title: 'some-title')
    content.save!
    content.id.wont_be_nil
  end

  it 'should populate error when path is not defined' do
    content = FactoryGirl.build(:content, {data: '{}', content_template_type: 'Calligraph::Template', content_template_id: template.id, path: nil, title: 'some-title'})
    refute content.valid?
    assert content.errors[:path].count >= 1
  end

  it 'should populate error when path is already used' do
    FactoryGirl.create(:content, {data: '{}', content_template_type: 'Calligraph::Template', content_template_id: template.id, path: '/some-path', title: 'some-title', meta_tags: []})
    content = FactoryGirl.build(:content, {data: '{}', content_template_type: 'Calligraph::Template', content_template_id: template.id, path: '/some-path', title: 'some-title-1', meta_tags: []})
    refute content.valid?
    assert content.errors[:path].count >= 1
  end

  it 'should populate error if template is nil' do
    content = FactoryGirl.build(:content, {data: '{}', content_template_type: 'Calligraph::Template', content_template_id: nil, path: '/some-path', title: 'some-title-1'})
    refute content.valid?
    assert content.errors[:content_template].count >= 1
  end

  it 'should populat error if json data is invalid' do
    content = FactoryGirl.build(:content, {data: '{', content_template_type: 'Calligraph::Template', content_template_id: template.id, path: '/some-path', title: 'some-title-1'})
    refute content.valid?
    assert content.errors[:data].count >= 1
  end

  it 'should populate error if data is not present' do
    content = FactoryGirl.build(:content, {data: nil, content_template_type: 'Calligraph::Template', content_template_id: template.id, path: '/some-path', title: 'some-title-1'})
    refute content.valid?
    assert content.errors[:data].count >= 1
  end

  it 'should store meta tags with each content page / action' do
    content = FactoryGirl.create(:content, meta_tags_attributes: [{name: 'title', value: 'Title'},{name: 'keywords', value: 'Site, Calligraph'},{name: 'separator', value: '-'}, {name:'nofollow', value: 'true'}], path: '/some-path')
    content.reload
    content.meta_tags_hash.must_equal({title: 'Title', keywords: 'Site, Calligraph', separator: '-', nofollow: 'true'}.stringify_keys)
    content.meta_tags_hash["title"].must_equal('Title')
  end
end