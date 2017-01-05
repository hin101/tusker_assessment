require 'rails_helper'

RSpec.describe BoxesController, type: :controller do
  let(:box) { FactoryGirl.create(:box) }

	describe 'GET #index' do
    it 'populates an array of boxes' do
      get :index
      expect(assigns(:boxes)).to eq([box])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new Box to @box' do
      get :new
      expect(assigns(:box)).to be_a_new(Box)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    before :each do
      @box = box
    end

    it 'finds the correct box' do
      get :show, params: { id: @box }
      expect(assigns(:box)).to eq(@box)
    end

    it 'renders the :show template' do
      get :show, params: { id: @box }
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new box in the database' do
        expect {
          post :create, params: { box: FactoryGirl.attributes_for(:box) }
        }.to change(Box, :count).by(1)
      end

      it 'redirects to the index category page' do
        post :create, params: { box: FactoryGirl.attributes_for(:box) }
        expect(response).to redirect_to boxes_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect {
          post :create, params: { box: FactoryGirl.attributes_for(:box, code: nil) }
        }.to_not change(Box, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { box: FactoryGirl.attributes_for(:user, code: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @box = FactoryGirl.create(:box)
    end

    context 'valid attributes' do
      it 'locates the requested box' do
        put :update, params: { id: @box, box: FactoryGirl.attributes_for(:box) }
        expect(assigns(:box)).to eq(@box)
      end

      it 'changes @box attributes' do
        put :update, params: { id: @box, box: FactoryGirl.attributes_for(:box, code: "Test") }
        @box.reload
        expect(@box.code).to eq("Test")
      end

      it 'redirects to :index' do
        put :update, params: { id: @box, box: FactoryGirl.attributes_for(:box, code: "Test") }
        expect(response).to redirect_to boxes_path
      end
    end

    context 'invalid attributes' do
      it 'locates the requested user' do
        put :update, params: { id: @box, box: FactoryGirl.attributes_for(:box) }
        expect(assigns(:box)).to eq(@box)
      end

      it 'does not change @box attributes' do
        put :update, params: { id: @box, box: FactoryGirl.attributes_for(:box, code: nil) }
        @box.reload
        expect(@box.code).to eq("BO1")
      end

      it 'render :edit' do
        put :update, params: { id: @box, box: FactoryGirl.attributes_for(:box, code: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do 
      @box = FactoryGirl.create(:box)
    end

    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: @box }
      }.to change(Box, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete :destroy, params: { id: @box }
      expect(response).to redirect_to boxes_path
    end
  end
end
