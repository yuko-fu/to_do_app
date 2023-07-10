require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  
  describe 'ユーザー登録機能' do
    context 'ユーザーの新規登録した場合' do
      it 'ユーザー新規登録できる' do
        visit new_user_path
        fill_in 'user_name', with: 'user1'
        fill_in 'user_email', with: 'user1@mail.com'
        fill_in 'user_password', with: 'user1@mail.com'
        fill_in 'user_password_confirmation', with: 'user1@mail.com'
        click_on '登録'

        expect(page).to have_content 'Login'
      end
    end

    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Login'
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインした場合' do
      it 'ログインできて詳細画面に遷移する'do
        visit new_session_path
          fill_in 'session_email', with: 'dpro@mail.com'
          fill_in 'session_password', with: 'dpro@mail.com'
        click_on 'Log in'
    
        expect(page).to have_content 'のページ'
      end  
    end
    context '一般ユーザが他人の詳細画面に飛んできた場合' do
      it 'タスク一覧画面に遷移する' do
        third_user = FactoryBot.create(:third_user)
        visit new_session_path
          fill_in 'session_email', with: 'dpro@mail.com'
          fill_in 'session_password', with: 'dpro@mail.com'
        click_on 'Log in'
        sleep(1)
        visit user_path(third_user.id)
        expect(page).to have_content "やること一覧"
      end
    end
    context 'ログアウト' do
      it 'ログアウトする' do
        visit new_session_path
        fill_in 'session_email', with: 'dpro@mail.com'
        fill_in 'session_password', with: 'dpro@mail.com'
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'Login'
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      FactoryBot.create(:admin1_user)
      FactoryBot.create(:admin2_user)
      FactoryBot.create(:admin3_user)
      FactoryBot.create(:admin4_user)
      FactoryBot.create(:admin5_user)
    end
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'session_email', with: 'admin1@mail.com'
        fill_in 'session_password', with: 'admin1@mail.com'
        click_on 'Log in'
        sleep(1)
        visit admin_users_path
        expect(page).to have_content '管理画面のユーザー一覧画面だよ！'
      end
      it 'ユーザーの新規登録ができる' do
        visit new_session_path
        fill_in 'session_email', with: 'admin2@mail.com'
        fill_in 'session_password', with: 'admin2@mail.com'
        click_on 'Log in'
        sleep(1)
        visit admin_users_path
        click_on '新規ユーザー作成'
        expect(page).to have_content 'ユーザー新規登録'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        visit new_session_path
        fill_in 'session_email', with: 'admin3@mail.com'
        fill_in 'session_password', with: 'admin3@mail.com'
        click_on 'Log in'
        sleep(1)
        visit admin_users_path
        page.all('#test_show')[1].click_on '詳細'
        expect(page).to have_content 'のページ'
      end
      it 'ユーザーの編集画面からユーザーを編集できる' do
        visit new_session_path
        fill_in 'session_email', with: 'admin4@mail.com'
        fill_in 'session_password', with: 'admin4@mail.com'
        click_on 'Log in'
        sleep(1)
        visit admin_users_path
        page.all('#test_edit')[1].click_on '編集'
        fill_in 'user_name', with: 'user8'
        fill_in 'user_email', with: 'user8@mail.com'
        fill_in 'user_password', with: 'user8@mail.com'
        fill_in 'user_password_confirmation', with: 'user8@mail.com'
        click_on '編集完了'
        expect(page).to have_content 'user8'
      end
      it 'ユーザーの削除ができる' do
        visit new_session_path
        fill_in 'session_email', with: 'admin5@mail.com'
        fill_in 'session_password', with: 'admin5@mail.com'
        click_on 'Log in'
        sleep(1)
        visit admin_users_path
        sleep(1)
        page.all('#test_delete')[1].click_on'削除'
        page.driver.browser.switch_to.alert.accept    
        expect(page).to have_content 'ユーザを削除しました。'
      end
    end

    context '一般ユーザーはアクセスできない' do
      it '管理画面にアクセスできない' do
        visit admin_users_path
        expect(page).to have_content 'Login'
      end
    end
  end
end