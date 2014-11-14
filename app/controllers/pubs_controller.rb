class PubsController < ApplicationController
  def index
    if params[:search] and params[:search][:query]
      @pubs = Pub.near(params[:search][:query])
      if @pubs.any?
        flash.now[:success] = "Showing pubs near #{params[:search][:query]}"
      else
        flash.now[:warning] = "No pubs near #{params[:search][:query]}"
      end
   else
      @pubs = Pub.all
    end
  end

  def new
    @pub = Pub.new
  end

  def create
    @pub = Pub.new(pub_params)
    if @pub.save
      flash[:success] = 'Thanks for the review'
    else
      flash[:error] = 'Sorry, couldn\'t do that'
      flash[:full] = @pub.errors.full_messages
      flash[:detail] = @pub.errors.each do | error |
      end
    end
    redirect_to pubs_path
  end

  def edit
     @pub = Pub.find(params[:id])
  end

  def update
    @pub = Pub.find(params[:id])
    if @pub.update(pub_params)
      flash[:success] = 'Thanks for the update'
      redirect_to edit_pub_path
   else
      flash[:error] = 'Sorry, there is nothing at this address.' if address_err?
      flash[:full] = @pub.errors.full_messages
      flash[:detail] = @pub.errors.each do | error |
        error
      end
      render :new
    end

  end

  def destroy
   if Pub.delete(params[:id])
      flash[:succes] = 'Another one bites the dust'
    else
      flash[:error] = 'Sorry, couldn\'t do that'
    end
    redirect_to pubs_path
  end

  private
  def pub_params
    params.require(:pub).permit(:name,:address,:website,:description,:latitude,:longitude)
  end

  def address_err?
    @pub.errors.full_messages == ["Latitude cannot be blank","Longitude cannot be blank"]
  end
end
