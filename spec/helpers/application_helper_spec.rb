require 'rails_helper'

describe ApplicationHelper do
  describe 'format_datetime' do
    it "can show date time with format %Y/%m/%d %H:%M:%S " do
      expect(format_datetime(Date.new(2017, 01, 01))).to eq '2017/01/01 00:00'
    end
  end

  describe 'format_datetime_ymd' do
    it "can show date time with format %Y/%m/%d" do
      expect(format_datetime_ymd(Date.new(2017, 01, 01))).to eq '2017/01/01'
    end
  end

  describe 'format_boolean' do
    it "show maru, batsu JP" do
      expect(format_boolean(true)).to eq "◯"
      expect(format_boolean(false)).to eq "✕"
      expect(format_boolean(nil)).to eq "✕"
    end
  end

  describe 'format_activity' do
    it "show active, inactive JP" do
      expect(format_activity(true)).to eq "有効"
      expect(format_activity(false)).to eq "無効"
      expect(format_activity(nil)).to eq "無効"
    end
  end

  describe 'active_namespace' do
    
  end
end
