class PinsController < ApplicationController
  # This is a Devise fnc. It's telling the app that
  # a user must be signed in in order to view
  # anything in the "pins controller", in this case
  # /pins/*, but we're allowing an exception--
  # anyone can view the list of pins, we're just not
  # letting them create, update or destroy
  # keyword: authentication
  before_filter :authenticate_user!, except: [:index]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.order("created_at desc")
    # Replaced with above to arrange in a new order
    # @pins = Pin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pins }
    end
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    @pin = Pin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pin }
    end
  end

  # GET /pins/new
  # GET /pins/new.json
  def new
    # This will create a pin within the pins for the
    # current user, thereby attributing the pin to 
    # the user
    # keyword: authentication
    @pin = current_user.pins.new
    # Replaced by the above
    # @pin = Pin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pin }
    end
  end

  # GET /pins/1/edit
  def edit
    @pin = current_user.pins.find(params[:id])
    # Replaced w/ the above to only user that
    # created a pin can edit it
    # keyword: authentication
    # @pin = Pin.find(params[:id])
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = current_user.pins.new(params[:pin])
    # Replaced with the above, to attribute pins to
    # the current user
    # keyword: authentication
    # @pin = Pin.new(params[:pin])

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render json: @pin, status: :created, location: @pin }
      else
        format.html { render action: "new" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pins/1
  # PUT /pins/1.json
  def update
    @pin = current_user.pins.find(params[:id])
    # Replaced for authication
    # @pin = Pin.find(params[:id])

    respond_to do |format|
      if @pin.update_attributes(params[:pin])
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin = current_user.pins.find(params[:id])
    # Replaced for authication
    # @pin = Pin.find(params[:id])
    @pin.destroy

    respond_to do |format|
      format.html { redirect_to pins_url }
      format.json { head :no_content }
    end
  end
end
