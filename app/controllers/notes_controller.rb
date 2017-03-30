class NotesController < ApplicationController
  include Pundit

  before_action :ensure_user,
    except: [:index, :show]

  def new
    @note = Note.new(user: current_user)
    authorize @note
  end

  def create
    @note = Note.new(note_params)
    authorize @note
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note }
        format.json { render 'show' }
      else
        format.html do
          puts @note.errors.inspect
          flash.now[:warning] = "Creation Error"
          render 'new'
        end
        format.json { render @note.errors, status: 401 }
      end
    end
  end

  def show
    @note = Note.friendly.find(params[:id])
    @replies = @note.replies
        .order(created_at: :asc)
        .paginate(page: page, per_page: 50)
        .includes(:user)
  end

  def index
    c = NoteIndexService.new(params)
    @notes = c.get_notes
  end

  def edit
    @note = Note.friendly.find(params[:id])
    authorize @note
  end

  def update
    @note = Note.friendly.find(params[:id])
    authorize @note
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: "updated" }
        format.json { render 'show' }
      else
        format.html do
          flash[:warning] = "Could not save"
          render 'edit'
        end
        format.json { render @note.errors, status: 401 }
      end
    end
  end

  def feed
    @notes = Note.feed_for(current_user).limit(40)
    if params[:fetch_after]
      time = Time.at(params[:fetch_after].to_f)
      @notes = @notes.where("notes.created_at < ?",time)
    end
    render 'index'
  end

  protected

  def note_params
    params.require(:note)
      .permit(:title,
              :body)
      .merge(user_id: current_user.id, slug: nil)
  end
end
