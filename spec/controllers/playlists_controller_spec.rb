require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      it "creates a new playlist" do
        expect {
          post :create, {:playlist => attributes_for(:playlist)}
        }.to change(Playlist, :count).by(1)
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template" do
        skip
        post :create, {:playlist => attributes_for(:playlist, name: nil)}
        expect(response).to render_template("new")
      end
    end

  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates a playlist" do
        playlist = create(:playlist)
        put :update, {:id => playlist.to_param, :playlist =>attributes_for(:playlist, name: "New name")}
        playlist.reload
        expect(playlist.name).to eq("New name")
      end
    end

    context "with invalid params" do
      it "assigns the playlist as @playlist" do
        playlist = create(:playlist)
        put :update, {:id => playlist.to_param, :playlist =>attributes_for(:playlist, name: nil)}
        expect(assigns(:playlist)).to eq(playlist)
      end
    end

  end
end
