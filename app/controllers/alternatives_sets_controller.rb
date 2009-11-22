class AlternativesSetsController < ApplicationController
  # GET /alternatives_sets
  # GET /alternatives_sets.xml
  def index
    @alternatives_sets = AlternativesSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alternatives_sets }
    end
  end

  # GET /alternatives_sets/1
  # GET /alternatives_sets/1.xml
  def show
    @alternatives_set = AlternativesSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alternatives_set }
    end
  end

  # GET /alternatives_sets/new
  # GET /alternatives_sets/new.xml
  def new
    @alternatives_set = AlternativesSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alternatives_set }
    end
  end

  # GET /alternatives_sets/1/edit
  def edit
    @alternatives_set = AlternativesSet.find(params[:id])
  end

  # POST /alternatives_sets
  # POST /alternatives_sets.xml
  def create
    @alternatives_set = AlternativesSet.new(params[:alternatives_set])

    respond_to do |format|
      if @alternatives_set.save
        flash[:notice] = 'AlternativesSet was successfully created.'
        format.html { redirect_to(@alternatives_set) }
        format.xml  { render :xml => @alternatives_set, :status => :created, :location => @alternatives_set }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @alternatives_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alternatives_sets/1
  # PUT /alternatives_sets/1.xml
  def update
    @alternatives_set = AlternativesSet.find(params[:id])

    respond_to do |format|
      if @alternatives_set.update_attributes(params[:alternatives_set])
        flash[:notice] = 'AlternativesSet was successfully updated.'
        format.html { redirect_to(@alternatives_set) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alternatives_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alternatives_sets/1
  # DELETE /alternatives_sets/1.xml
  def destroy
    @alternatives_set = AlternativesSet.find(params[:id])
    @alternatives_set.destroy

    respond_to do |format|
      format.html { redirect_to(alternatives_sets_url) }
      format.xml  { head :ok }
    end
  end
end
