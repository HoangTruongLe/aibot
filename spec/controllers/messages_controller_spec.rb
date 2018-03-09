require 'rails_helper'

describe MessagesController do
  let(:admin) {create(:user, :admin)}
  let(:question) {create(:question)}

  before(:each) do
    sign_in admin
  end

  # describe 'GET #index' do
  #   it 'should show a list of questions' do
  #     questions = create_list(:question, 3)
  #
  #     get :index
  #     expect(assigns(:questions)).to match_array(questions)
  #   end
  # end
  #
  # describe 'GET #show' do
  #   it 'should show a specific question' do
  #     get :show, params: {id: question.id}
  #     expect(assigns(:question)).to eq(question)
  #   end
  # end
  #
  # describe 'GET #new' do
  #   it 'create a new question' do
  #     get :new
  #     expect(assigns(:question)).to be_a_new(Question)
  #   end
  # end
  #
  # describe 'POST #create' do
  #   context 'with valid attributes' do
  #     it 'creates a new question' do
  #       expect{
  #         post :create, params: {question: attributes_for(:question)}
  #       }.to change(Question, :count).by(1)
  #
  #       expect(response).to redirect_to(messages_path)
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     it 'does not save the new question' do
  #       expect{
  #         post :create, params: {question: attributes_for(:question, content: '')}
  #       }.to_not change(Question, :count)
  #     end
  #
  #     it 'render to new action' do
  #       post :create, params: {question: attributes_for(:question, content: '')}
  #       expect(response).to render_template :new
  #     end
  #   end
  # end
  #
  # describe 'GET #edit' do
  #   it 'should edit a specific question' do
  #     get :edit, params: {id: question.id}
  #     expect(assigns(:question)).to eq(question)
  #   end
  # end
  #
  # describe 'PUT #update' do
  #   it 'in case of succeed' do
  #     put :update, params: {id: question.id, question: attributes_for(:question, content: 'updated_content')}
  #     question.reload
  #
  #     expect(question.content).to eq 'updated_content'
  #     expect(flash[:notice]).to be_present
  #     expect(response).to redirect_to(messages_path)
  #   end
  #
  #   it 'in case of failure' do
  #     put :update, params: {id: question.id, question: attributes_for(:question, content: '')}
  #     expect(response).to render_template :edit
  #   end
  # end
  #
  # describe 'DELETE #destroy' do
  #   it 'should destroy a question' do
  #     expect{
  #       delete :destroy, params: {id: question.id}
  #     }.to change(Question, :count).by(0)
  #
  #     expect(flash[:notice]).to be_present
  #     expect(response).to redirect_to(messages_path)
  #   end
  # end
end
