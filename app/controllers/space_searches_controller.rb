class SpaceSearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    # if search_params[:location] != ""
    #   search = search_params[:location]

      # geo = Geocoder.coordinates(search, params: {region: "pt", language: "pt"})
      # latitude = geo[0]
      # longitude = geo[1]
      @spaces = Space.search "*", where: search_conditions


      # {
      #   location: {
      #     near: {lat: latitude, lon: longitude},
      #     within: "10km"
      #   },
      #   covered: search_params[:covered]
      # }
    # else
    #   @spaces = Space.all
    # end

      @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
        marker.lat space.latitude
        marker.lng space.longitude
      end
  end

  private

  # def search_params
  #   search_params = params.require(:search).permit(:location, :start_date, :end_date, :covered)
  #   if search_params[:covered].present? && search_params[:covered] != ""
  #      search_params[:covered] = search_params[:covered] == "true" ? true : false
  #   end
  #   search_params
  # end

  def search_conditions
    search_conditions = {}
    search_params = params.require(:search).permit(:location, :start_date, :end_date, :price, :covered, :staff, :valet, :gate, :cctv, :charging, :water, :price_cents)

    # for boolean types

    booleans = [:covered, :staff, :valet, :gate, :cctv, :charging, :water]

    booleans.each do |bool|
      if search_params[bool].present? && search_params[bool] != "" && search_params[bool] == "true"
         search_conditions[bool] = true
      end
    end

    # for locations

    if search_params[:location].present? && search_params[:location] != ""
      geo = Geocoder.coordinates(search_params[:location], params: {region: "pt", language: "pt"})
      latitude = geo[0]
      longitude = geo[1]
      search_conditions[:location] = {
                                  near: {
                                    lat: latitude,
                                    lon: longitude
                                    },
                                  within: "1km"
                                }
    end

    if search_params[:start_date].present? && search_params[:start_date] != ""
        # search_conditions[:start_date] = {gte: search_params[:start_date].to_date}
        search_conditions[:unavailable_dates] = {not: search_params[:start_date].to_date}
    end

    if search_params[:end_date].present? && search_params[:end_date] != ""
        # search_conditions[:end_date] = {lte: search_params[:end_date].to_date}
        search_conditions[:unavailable_dates] = {not: search_params[:end_date].to_date}
    end

    if search_params[:start_date].present? && search_params[:start_date] != "" && search_params[:end_date].present? && search_params[:end_date] != ""
        # search_conditions[:start_date] = search_params[:start_date].to_date..search_params[:end_date].to_date
        # search_conditions[:end_date] = search_params[:start_date].to_date..search_params[:end_date].to_date
        search_conditions[:unavailable_dates] = {not: (search_params[:start_date].to_date..search_params[:end_date].to_date).to_a}
    end


    if search_params[:price_cents].present? && search_params[:price_cents] != ""
      search_params[:price_cents] = search_params[:price_cents].split(',').map{|price_cents| price_cents.to_i*100}
      search_conditions[:price_cents] = search_params[:price_cents][0]..search_params[:price_cents][1]
    end

    search_conditions
  end
end
