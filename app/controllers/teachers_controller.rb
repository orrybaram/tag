
class TeachersController < ApplicationController
  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @teachers }
    end
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @teacher }
    end
  end

  # GET /teachers/new
  # GET /teachers/new.json
  def new
    @teacher = Teacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @teacher }
    end
  end

  # GET /teachers/1/edit
  def edit
    @teacher = Teacher.find(params[:id])
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(params[:teacher])

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to '/teachers/home', :notice => 'Teacher was successfully created.' }
      else
        format.html { render :action => "new" }
        format.json { render :json => @teacher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teachers/1
  # PUT /teachers/1.json
  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to @teacher, :notice => 'Teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @teacher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :no_content }
    end
  end

  # class_list
  #   INPUT: teacher_id (session value)
  #   OUTPUT: classes (Class.object)
  #   FROM: views/teachers/home
  #   TO: views/teachers/class_list
  #   2012.7.9 Yueying
  def class_list
    @pe_classes = PeClass.find_all_by_teacher_id(session[:teacher_id])
  end

  # student_list
  #   INPUT: pe_class_id (value)
  #   OUTPUT: user (User.object)
  #   FROM: views/teachers/class_list
  #   TO: views/teachers/student_list
  #   2012.7.10 Yueying
  def student_list
    @users = User.find_all_by_pe_class_id(params[:pe_class_id])
  end

  # student_information
  #   INPUT: user_id (value)
  #   OUTPUT: team (Team.object)
  #   FROM: views/teachers/student_list
  #   TO: views/teachers/student_information
  #   2012.7.10 Yueying
  def student_information
team = Team.find_by_user1(params[:user_id])
    @team = Team.find_by_user1(params[:user_id])
teammate = Team.find_teammate(params[:user_id])
debugger
    @teammate = Team.find_teammate(params[:user_id])
  end
end
