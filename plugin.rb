# name: discourse-self-delete
# about: A sample plugin allows self account deletion.
# version: 0.1
# authors: Misaka 0x4e21
# url: https://github.com/misaka4e21/discourse-self-delete

after_initialize do
  module ::PostGuardian
    def can_delete_all_posts?(user)
      return false if anonymous?
      super(user) || user.id == @user.id
    end
  end

  module ::TopicGuardian
    def can_delete_topic?(topic)
      return false if anonymous?
      super(topic) || topic.user_id == @user.id
    end
  end
end
