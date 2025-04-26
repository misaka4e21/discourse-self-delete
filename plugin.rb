# name: discourse-self-delete
# about: A sample plugin allows self account deletion.
# version: 0.2
# authors: Misaka 0x4e21
# url: https://github.com/misaka4e21/discourse-self-delete

after_initialize do
  TopicGuardian.module_eval do
    def can_delete_topic?(topic)
      return false if topic&.user&.admin? && !is_my_own(topic)
      is_staff? || is_category_group_moderator?(topic.category) || is_my_own?(topic)
    end
  end
  PostGuardian.module_eval do
    def can_delete_all_posts?(user)
      return false if !is_me?(user) && user&.admin?
      !user.nil? && (is_staff? || @user == user)
    end

    def can_delete_post?(post)
      return false if !is_me?(post&.user) && post&.user&.admin?
      is_staff? || is_category_group_moderator?(post&.topic&.category) || is_my_own?(post)
    end
  end
  UserGuardian.module_eval do
    def can_delete_user?(user)
      return false if user.nil? || user&.admin?

      is_me?(user) || is_staff?
    end
  end
end
