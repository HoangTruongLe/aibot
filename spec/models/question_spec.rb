require 'rails_helper'

describe Question do
	# let(:question) {create(:question)}
	#
	# describe 'association' do
	# 	it {should belong_to(:answer)}
	# 	it {should have_many(:answers).dependent(:destroy)}
	# 	it {should accept_nested_attributes_for(:answers)}
	# end
	#
	# describe 'validation' do
	# 	it {should validate_presence_of(:content)}
	# end
	#
	# describe 'enum' do
	# 	# it {should define_enum_for(:question_type).with({"オープンメッセージ" => 1, "ミドルメッセージ" => 2, "クロージングメッセージ" => 3})}
	# 	# it {should define_enum_for(:question_level).with({"list_product" => 0, "product" => 1})}
	# end
	#
	# describe 'ransack' do
	# 	it 'convert id to string in order to use cont predicate' do
	# 		expect(Question.ransack(id_eq: question.id).result.to_sql).to include("to_char(\"questions\".\"id\", '99999999') = '#{question.id}'")
	# 	end
	# end
	#
	# describe 'scope' do
	# 	# before(:each) do
	# 	# 	@open_question = create(:question, :type_is_open)
	# 	# 	@middle_question = create(:question, :type_is_middle)
	# 	# 	@close_question = create(:question, :type_is_close)
	# 	# end
	# 	#
	# 	# it 'filter question with type is open' do
	# 	# 	expect(Question.open_messages).to match_array(@open_question)
	# 	# end
	# 	#
	# 	# it 'filter question with type is middle' do
	# 	# 	expect(Question.middle_messages).to match_array(@middle_question)
	# 	# end
	# 	#
	# 	# it 'filter question with type is close' do
	# 	# 	expect(Question.close_messages).to match_array(@close_question)
	# 	# end
	# 	#
	# 	# it 'filter question with have no answer' do
	# 	# 	expect(Question.middle_messages_start).to include(@open_question, @middle_question, @close_question)
	# 	# end
	# end
end
