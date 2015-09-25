##
# Manages TagGroupChanges.
#
# Allows them to vote on them and stuff. 
class TagGroupChangesController < ApplicationController
  ##
  # Find all the changes for one tag_group
  # 
  # This is an EVIL DOUBLE NESTED ROUTE.
  #
  # As such, both image_id and tag_group_id should be set
  def index
    @changes = TagGroup.find(params[:tag_group_id]).tag_group_changes
  end
end
