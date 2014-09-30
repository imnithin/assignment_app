class PlansController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, except: :public

  caches_page :show, :new
  caches_action :index, :show
  # GET /plans
  # GET /plans.json
  def index
    if current_user.is_admin?
      @plans = Plan.all
    else
      @plans = Plan.where(user_id: current_user.id)
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    respond_to do |format|
      if @plan.save
        # expire_fragment("plans")
        expire_action :action => 'index'
        UserMailer.create_plan(current_user, @plan).deliver
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      # expire_fragment("plans")
      expire_action :action => 'index'
      expire_action :action => 'show'
      expire_page action: 'show', id: params[:id]
      redirect_to action: 'show', id: params[:id]
    else
      render "edit"
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    expire_action :action => 'index'
    expire_action :action => 'show'
    expire_page action: 'show', id: params[:id]
    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title, :name, :detail,:user_id)
    end
  end
