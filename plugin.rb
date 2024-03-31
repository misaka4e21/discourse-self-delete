# name: discourse-self-delete
# about: A sample plugin allows self account deletion.
# version: 0.1
# authors: Misaka 0x4e21
# url: https://github.com/misaka4e21/discourse-self-delete

after_initialize do
  plugin = Plugin::Instance.new
  cb = Proc.new do |user, guardian, opts|
    Post.where(user_id: user.id).delete_all
  end
  plugin.register_user_destroyer_on_content_deletion_callback(cb)
end
