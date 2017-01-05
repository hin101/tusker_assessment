require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:user1) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    it 'populates an array of users' do
      get :index
      expect(assigns(:users)).to eq([user1])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect {
          post :create, params: { user: FactoryGirl.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the index category page' do
        post :create, params: { user: FactoryGirl.attributes_for(:user) }
        expect(response).to redirect_to users_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect {
          post :create, params: { user: FactoryGirl.attributes_for(:user, name: nil) }
        }.to_not change(User, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { user: FactoryGirl.attributes_for(:user, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    context 'valid attributes' do
      it 'locates the requested user' do
        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user) }
        expect(assigns(:user)).to eq(@user)
      end

      it 'changes @user attributes' do
        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user, name: "Test") }
        @user.reload
        expect(@user.name).to eq("Test")
      end

      it 'redirects to :index' do
        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user, name: "Test") }
        expect(response).to redirect_to users_path
      end
    end

    context 'invalid attributes' do
      it 'locates the requested user' do
        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user) }
        expect(assigns(:user)).to eq(@user)
      end

      it 'does not change @user attributes' do
        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user, name: nil) }
        @user.reload
        expect(@user.name).to eq("User 1")
      end

      it 'redirects to :edit' do
        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user, name: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do 
      @user = FactoryGirl.create(:user)
    end

    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: @user }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to users_path
    end
  end
end
