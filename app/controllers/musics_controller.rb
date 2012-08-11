
class MusicsController < ApplicationController
  # GET /musics
  # GET /musics.json
  def index
    @musics = Music.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @musics }
    end
  end

  # GET /musics/1
  # GET /musics/1.json
  def show
    @music = Music.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @music }
    end
  end

  # GET /musics/new
  # GET /musics/new.json
  def new
    @music = Music.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @music }
    end
    
  end

  # GET /musics/1/edit
  def edit
    music = Music.find(params[:id])
  end

  # POST /musics
  # POST /musics.json
  def create
    @music = Music.new(params[:music])
    @music.user_id = session[:user_id]
    @music.save

    respond_to do |format|
      if @music.save
        format.html {redirect_to "/admin/home"}
      end
    end
  end

  # PUT /musics/1
  # PUT /musics/1.json
  def update
    @music = Music.find(params[:id])

    respond_to do |format|
      if @music.update_attributes(params[:music])
        format.html { redirect_to @music, :notice => 'Music was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @music.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1
  # DELETE /musics/1.json
  def destroy
    @music = Music.find(params[:id])
    @music.destroy

    respond_to do |format|
      format.html { redirect_to musics_url }
      format.json { head :no_content }
    end
  end

  # music_list
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW music (Music.object), SAVE music_like
  #   FROM: views/classes/home
  #   TO: views/musics/music_list
  #   2012.7.3 Yueying
  def music_list
    @musics = Music.find_musics_by_user(session[:user_id])
     
    music_like = MusicLike.new
    music_like.user_id = session[:user_id]
    hash = params[:like]
    if  hash != nil
      hash_invert = hash.invert
      music_like.music_id = hash_invert.values_at("like").first.to_i
      music_like.save

      music = music_like.music
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE musics SET musics.popularity = musics.popularity + 1 WHERE musics.id = " + music.id.to_s)
    end
  end
end
