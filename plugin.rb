# name: discourse-self-delete
# about: A sample plugin allows self account deletion.
# version: 0.1
# authors: Misaka 0x4e21
# url: https://github.com/misaka4e21/discourse-self-delete

after_initialize do
  UsersController.class_eval do
    def destroy
      @user = fetch_user_from_params
      guardian.ensure_can_delete_user!(@user)

      UserDestroyer.new(current_user).destroy(@user, delete_posts: true, context: params[:context], prepare_for_destroy: true)

      render json: success_json
    end
  end
end
