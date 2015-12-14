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
#== Relations
# commentable:: What this comment is on
# user:: Who commented
# notifications:: Notifications that reference this comment. Used for people 
#                 who reply to a comment or iamge.
class Comment < ActiveRecord::Base
  
  scope :for_display, ->{ includes(:user).order("created_at ASC") }
  #############
  # RELATIONS #
  #############
  belongs_to :commentable, polymorphic: true,
    touch: true
  belongs_to :user
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
  after_save :notify_image
  ####################
  # INSTANCE METHODS #
  ####################
  protected

  ##
  # Notify_image sends a notification to the image owner
  # when a user comments on their image--if they have it set to do so
  def notify_image
    if commentable.class == Image && commentable.replies_to_inbox
      n = Notification.create(user: commentable.user,
                              subject: self,
                              kind: :uploaded_image_commented_on)
      n.save
    end
  end

  
  ##
  # Notify reply tells us to make a notification of a reply to
  # this comment. It's protected so only other comments can
  # call it.
  def notify_reply(other)
    n = Notification.create(user: user,
                            subject: self,
                            kind: :comment_replied_to)
    n.save

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
    users.each{|u| notify_mention(u) unless u == self.user}
  end

  ##
  # Make a new notification for a user mentioned in this comment.
  # user:: the user to notify.
  def notify_mention(user)
    n = Notification.new(user: user,
                         subject: self,
                         kind: :mentioned)
    n.save!
  end  

end
