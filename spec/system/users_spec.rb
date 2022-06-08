require 'rails_helper'

describe 'ユーザー管理機能' do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', id: 1) }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', id: 2) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス',	with: login_user.email
    fill_in 'パスワード',	with: login_user.password
    click_button 'ログイン'
  end

  describe 'ログイン保持機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAの名前が表示される' do
        expect(page).to have_content 'ユーザーA'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAの名前が表示されない' do
        expect(page).to have_no_content 'ユーザーA'
      end
    end
  end
end
