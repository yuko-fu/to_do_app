require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end
  describe 'ユーザー登録機能' do
    context 'ユーザーの新規登録した場合' do
      it 'ユーザー新規登録できる' do
        visit new_user_path
        click_on '登録'

        expect(page).to have_content 'D-robot'
      end
    end

    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        exact(page).to have_content 'Login'
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインした場合' do
      it 'ログインできて詳細画面に遷移する'do
        visit new_session_path
        # fill_in 'session_session_email', with: 'D-robot@mail.com'
        # fill_in 'session_session_password', with: '123456'
        click_on 'Log in'
    
        exact(page).to have_content 'D-robot@mail.com'
      end  
    end
    context '一般ユーザが他人の詳細画面に飛んできた場合' do
      it 'タスク一覧画面に遷移する' do
        another_user = User.create(name: 'Another User', email: 'another@example.com', password: 'password')
        visit user_path(another_user)
        expect(current_path).to eq(tasks_path)
      end
    end
    context 'ログアウト' do
      it 'ログアウトする' do
        click_on Logout
        exact(page).to have_content 'Login'
      end
    end
  end

  describe '管理画面のテスト' do
    let(:admin_user) { FactoryBot.create(:user, :admin) }
    let(:regular_user) { FactoryBot.create(:user) }
    end
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできる' do
        login_as(admin_user)
        visit admin_users_path
        exact(page).to have_content '管理画面のユーザー一覧画面だよ！'
      end
      it 'ユーザーの新規登録ができる' do
        login_as(admin_user)
        visit admin_user_path
        click_on '新規ユーザー作成'
        exact(page).to have_content 'ユーザー新規登録'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        login_as(admin_user)
        visit admin_user_path
        click_on '詳細'
        exact(page).to have_content 'のページ'
      end
      it 'ユーザーの編集画面からユーザーを編集できる' do
        login_as(admin_user)
        visit admin_user_path
        click_on '編集'
        exact(page).to have_content 'アカウント編集'
      end
      it 'ユーザーの削除ができる' do
        login_as(admin_user)
        visit admin_user_path
        click_on '削除'
        exact(page).to have_content 'のページ'
      end

    context '一般ユーザーはアクセスできない' do
      login_as(regular_user)
      visit admin_users_path
      exact(page).to have_content


    end

  end
end