require 'rails_helper'

RSpec.describe Site, type: :model do
  let(:site) { Site.create(name: "Site 1", site_url: "http://chicoli.net") }
  describe 'association' do
    it { should have_one(:api_key) }
    it { should have_many(:products) }
    it { should have_many(:product_statistics) }
    it { should have_many(:product_reports) }
    it { should belong_to(:user) }
  end

  describe 'validation' do
    it {should validate_presence_of(:name)}
		it {should validate_presence_of(:site_url)}
  end

  describe 'callback' do
		it 'before_create :generate_new_key' do
			expect(site.api_key.access_token).to_not be_empty
		end
	end

  describe 'ransack' do
		it 'convert id to string in order to use cont predicate' do
			expect(Site.ransack(id_eq: site.id).result.to_sql).to include("to_char(\"sites\".\"id\", '99999999') = '#{site.id}'")
		end
	end
end
