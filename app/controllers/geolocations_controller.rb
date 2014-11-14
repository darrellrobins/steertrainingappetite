class GeolocationsController < ApplicationController
  def get
  	b=Geocoder.search(params[:address])
  	a={}
  	a['latitude']=1.3
  	a['longitude']=0
  	respond_to do |format|
      	format.html
      	format.json { render json: b}
    end
  end
end
