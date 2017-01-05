require 'rails_helper'

RSpec.describe ContentsController, type: :controller do
  let(:content) { FactoryGirl.create(:content) }

  describe 'GET #index' do
    it 'populates an array of contents' do
      get :index
      expect(assigns(:contents)).to eq([content])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new Content to @content' do
      get :new
      expect(assigns(:content)).to be_a_new(Content)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new content in the database' do
        expect {
          post :create, params: { content: FactoryGirl.attributes_for(:content) }
        }.to change(Content, :count).by(1)
      end

      it 'redirects to the index content page' do
        post :create, params: { content: FactoryGirl.attributes_for(:content) }
        expect(response).to redirect_to contents_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new content in the database' do
        expect {
          post :create, params: { content: FactoryGirl.attributes_for(:content, content: nil) }
        }.to_not change(Content, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { content: FactoryGirl.attributes_for(:content, content: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @content = FactoryGirl.create(:content)
    end

    context 'valid attributes' do
      it 'locates the requested content' do
        put :update, params: { id: @content, content: FactoryGirl.attributes_for(:content) }
        expect(assigns(:content)).to eq(@content)
      end

      it 'changes @content attributes' do
        put :update, params: { id: @content, content: FactoryGirl.attributes_for(:content, content: "Test") }
        @content.reload
        expect(@content.code).to eq("Test")
      end

      it 'redirects to :index' do
        put :update, params: { id: @content, content: FactoryGirl.attributes_for(:content, content: "Test") }
        expect(response).to redirect_to contents_path
      end
    end

    context 'invalid attributes' do
      it 'locates the requested content' do
        put :update, params: { id: @content, content: FactoryGirl.attributes_for(:content) }
        expect(assigns(:content)).to eq(@content)
      end

      it 'does not change @content attributes' do
        put :update, params: { id: @content, content: FactoryGirl.attributes_for(:content, content: nil) }
        @content.reload
        expect(@content.content).to eq("1a")
      end

      it 'render :edit' do
        put :update, params: { id: @content, content: FactoryGirl.attributes_for(:content, content: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do 
      @box = FactoryGirl.create(:box)
    end

    it 'deletes the content' do
      expect {
        delete :destroy, params: { id: @content }
      }.to change(Content, :count).by(-1)
    end

    it 'redirects to contents#index' do
      delete :destroy, params: { id: @content }
      expect(response).to redirect_to contents_path
    end
  end
end
