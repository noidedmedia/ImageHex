##
# A comment is a model polymorphically related to other models which, as the name suggests, allows commenting.
# In a comment, you can mention another user by putting an "@" and then their username.
# Like so:
#     "@connorshea I dunno, it needs to pop more."
#
# You can also reply to one or more other comments by putting ">>" and the ID of the comment.
# Behold:
#     ">>1230 no you idiot you know nothing about design"
# 
# To include an image, reference its id with a # in front. Like so:
#     "#123 is like this image but less awesome"
# Replies and mentions generate a one-time notification and are otherwise only loosely related on the frontend via javascript.
# We do not store references to mentioned users or replied comments in this model.
#
class Comment < ActiveRecord::Base
  #############
  # RELATIONS #
  #############
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :notifications, as: :subject
  ###############
  # VALIDATIONS #
  ###############

  validates :user, presence: true
  validates :commentable, presence: true
  validates :body, presence: true

  #############
  # CALLBACKS #
  #############
  after_save :notify_mentioned_users
  after_save :notify_replied_comments
  ####################
  # INSTANCE METHODS #
  ####################

  protected
  ##
  # Notify reply tells us to make a notification of a reply to
  # this comment. It's protected so only other comments can 
  # call it.
  def notify_reply(other)
    n = Notification.create(user: user,
                            subject: self,
                            message: reply_message(other))
    n.save

  end

  ##
  # Notifiation message just returns a string to use as the message
  # in a notification
  def reply_message(other)
    "#{other.user.name} replied to your comment on #{commentable_type} ##{commentable_id}"
  end
  ##
  # You can reply to another comment 4chan-style, by typing
  #     >>#{id of other comment}
  # So we find those here, and generate notifications
  def notify_replied_comments
    # find all matches of our ">>" pattern
    ids = body.scan(/>>\d+/)
      .map{|m| m.gsub(">>", "")} # then remove the >> to get just the ids
    comments = Comment.where(id: ids)
    comments.map{|x| x.notify_reply(self)}
  end

  ## 
  # Parse the body of the comment, find all mentioned users,
  # notify them
  def notify_mentioned_users
    ##
    # All words that start with an @ until the spaces
    names = body.scan(/@\w+/)
      .map{|m| m.gsub("@", "")}
    users = User.where(name: names)
    users.each{|u| notify_mention(u)}
  end

  def notify_mention(user)
    n = Notification.new(user: user,
                     subject: self,
                     message: mention_message(user))
    n.save!
  end

  def mention_message(user)
    "#{self.user.name} mentioned you in a comment"
  end

end
