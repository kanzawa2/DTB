class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy, :reuse, :diff]

  # GET /missions
  # GET /missions.json
  def index
    @missions = Mission.all
    @missions = @missions.where(parent_id: params[:parent_id]) unless params[:parent_id].nil?
    @missions = @missions.roots if params[:roots] == 'true'

    respond_to do |format|
      format.html
      format.json
      format.occurrence { render json: @missions.map(&:to_occurrences).flatten }
    end
  end

  # GET /missions/1
  # GET /missions/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.occurrence do
        render json: @mission.children.map(&:to_occurrences) +
          @mission.tasks.map(&:to_occurrences)
      end
    end
  end

  # GET /missions/new
  def new
    @mission = Mission.new
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions
  # POST /missions.json
  def create
    @mission = Mission.new(mission_params)

    respond_to do |format|
      if @mission.save
        format.html do
          flash[:success] = 'Mission was successfully created.'
          redirect_to @mission
        end
       format.json { render action: 'show', status: :created, location: @mission }
      else
        format.html { render action: 'new' }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /missions/1
  # PATCH/PUT /missions/1.json
  def update
    respond_to do |format|
      if @mission.update(mission_params)
        format.html do
          flash[:success] = 'Mission was successfully updated.'
          redirect_to @mission
        end
        format.json { render action: 'show', status: :ok, location: @mission }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.json
  def destroy
    @mission.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def organize
    @missions = Mission.roots
  end

  def simple_create
    state = State.find_by(default: true)
    if state.nil?
      flash[:warning] = 'Set default state in Setting.'
    else
      @mission = Mission.new(name: params[:name], parent_id: params[:parent_id], state_id: state.id)
      @mission.save ? flash[:success] = 'Mission was successfully created.' :
                      flash[:warning] = 'Failed to create mission.'
    end
    redirect_to :back
  end

  def reuse
    @new_mission = @mission.deep_clone except: [:deadline, :state_id]
    @new_mission.state_id = State.find_by(default: true).id
    @new_mission.save
    create_reuse_relationship(@mission.id, @new_mission.id)
    copy_children(@mission, @new_mission)
    
    redirect_to :back
  end

  def diff
    @source_mission = @mission.reuse_source
    str = ""
    @strdst_mission = compare_mission(@mission, @source_mission, str)
    @strsrc_mission = compare_mission(@source_mission, @mission, str)
    # @strdst_task = str + compare_task(@mission, @source_mission, str)
    # @strsrc_task = str + compare_task(@source_mission, @mission, str)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mission
    @mission = Mission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mission_params
    params.require(:mission).permit(:id, :name, :description, :deadline, :state_id, :keyword, :parent_id, :source_id)
  end

  def copy_children(mission, new_mission)
    mission.tasks.reverse_each do |task|
      new_task = task.deep_clone except: [:deadline, :state_id]
      new_task.mission_id = new_mission.id
      new_task.state_id = State.find_by(default: true).id
      new_task.save
      end
    mission.children.reverse_each do |child|
      new_child = child.deep_clone except: [:deadline, :state_id]
      new_child.state_id = State.find_by(default: true).id
      new_child.save
      new_child.move_to_child_of(new_mission)
      create_reuse_relationship(child.id, new_child.id)
      if child.children.nil? && child.tasks.nil? then
        return
      end
      copy_children(child, new_child)
    end
  end

  def create_reuse_relationship(source_id, destination_id)
    reuse_relationship = ReuseRelationship.new(source_id: source_id, destination_id: destination_id)
    reuse_relationship.save
  end


  def compare_task(mission1, mission2, str)
    if mission1.tasks == nil then
      return str
    end
    mission1.tasks.each do |task1|
      cnt = mission2.tasks.count
      if cnt == 0 then
        str += "Task #{task1.name} (in #{mission1.name})\n"
        break
      end
      mission2.tasks.each do |task2|
        if task1.name == task2.name then
          break
        end
        cnt = cnt - 1
        str += "Task #{task1.name} (in #{mission1.name})"  if cnt == 0
      end
    end
    return str
  end

  def compare_mission(mission1, mission2, str)
    # if mission1.children == nil then
    #   return str
    # end

    mission1.children.each do |child1|
      cnt = mission2.children.count
      if cnt == 0 then
        str += "Mission #{child1.name} (in #{mission1.name})\n"
        break
      end
      mission2.children.each do |child2|
        if child1.name == child2.name then
          str = compare_mission(child1, child2, str)
          break
        end
        cnt = cnt - 1
        if cnt == 0 then
          str += "Mission #{child1.name} (in #{mission1.name})\n"
        end
      end
    end
    str = compare_task(mission1, mission2, str)
    return str
  end
end
