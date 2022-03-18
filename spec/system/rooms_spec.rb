require 'rails_helper'

describe 'ルーム管理機能' do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', id: 1) }
  let!(:room_a) { FactoryBot.create(:room, name: '最初のルーム', user: user_a) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス',	with: login_user.email
    fill_in 'パスワード',	with: login_user.password
    click_button 'ログイン'
  end

  describe '登録ルーム表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit "/users/#{login_user.id}/posts"
      end

      it 'ユーザーAが作成したルームが表示される' do
        expect(page).to have_content '最初のルーム'
      end
    end
  end

  describe 'ルーム新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_room_path
      fill_in 'ルーム名',	with: room_name
      fill_in '住所',	with: room_address
      fill_in '一泊料金',	with: room_price
      fill_in '紹介文',	with: room_introduction
      attach_file '画像', 'spec/images/test_image.jpeg'
      click_button '新規登録する'
    end

    context '新規作成画面で内容を入力したとき' do
      let(:room_name) { '新しいルーム' }
      let(:room_address) { '北海道' }
      let(:room_price) { '5000' }
      let(:room_introduction) { '新しいルームです' }

      it '正常に登録される' do
        expect(page).to have_content '新しいルーム'
      end
    end

    context '新規作成画面でルーム名を入力しなかったとき' do
      let(:room_name) { '' }
      let(:room_address) { '北海道' }
      let(:room_price) { '5000' }
      let(:room_introduction) { '新しいルームです' }

      it 'エラーとなる' do
        expect(page).to have_content 'ルーム名を入力してください'
      end
    end
  end
end
