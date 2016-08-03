RSpec.shared_context "when signed in" do
  before(:each) do
    @user = create(:user)
    @user.confirm
    login_as(@user, scope: :user)
  end
end
