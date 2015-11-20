class SubscriptionQuery
  def initialize(user)
    @user = user
  end

  def result
    union = find_collections
      .union(find_artist_subscriptions)
    Image.from(images.create_table_alias(union, :images))
  end

  def find_collections
    images
    .join(collection_images)
    .on(collection_images[:image_id].eq(images[:id]))
    .join(collections)
    .on(collections[:id].eq(collection_images[:collection_id]))
    .join(subscriptions)
    .on(subscriptions[:collection_id].eq(collections[:id]))
    .where(subscriptions[:user_id].eq(@user.id))
    .project(images[Arel.star],
             Arel::Nodes::SqlLiteral.new("'collection'").as("reason_type"),
             collections[:name].as("reason"),
             collections[:id].as("reason_id"),
             collection_images[:created_at].as("sort_created_at"))
  end

  def find_artist_subscriptions
    images
    .join(user_creations)
    .on(user_creations[:creation_id].eq(images[:id]))
    .join(users)
    .on(users[:id].eq(user_creations[:user_id]))
    .join(artist_subscriptions)
    .on(artist_subscriptions[:artist_id].eq(user_creations[:user_id]))
    .where(artist_subscriptions[:user_id].eq(@user.id))
    .project(images[Arel.star],
             Arel::Nodes::SqlLiteral.new("'user'").as("reason_type"),
             users[:name].as("reason"),
             users[:id].as("reason_id"),
             user_creations[:created_at].as("sort_created_at"))
  end

  def user_creations
    @_user_creations ||= UserCreation.arel_table
  end

  def users
    @_users ||= User.arel_table
  end

  def artist_subscriptions
    ArtistSubscription.arel_table
  end

  def images
    @_images ||= Image.arel_table
  end

  def collections
    @_collections ||= Collection.arel_table
  end

  def subscriptions
    @_subscriptions ||= Subscription.arel_table
  end

  def collection_images
    @_collection_images ||= CollectionImage.arel_table
  end
end
