class Api::V1::SearchController < ApplicationController
  #before_action :authenticate_with_token!, only: [:create]
  respond_to :json
  


  def create
    # Universities search
    if params[:university]
      filters = params[:university]
      # If no filters we do a regular query
      unless filters.size > 0
        render json:University.all.includes(:campu,campu: :city).order("institutions.title ASC"), status:200
        return
      end
      result = University.search(include:[:university_type]) do
        order_by(:id, :asc)
        paginate(page:params[:page] || 1 ,per_page: 20)
          if filters[:text]
            fulltext filters[:text], fields:[:title,:nick,:initials]
          end
          all_of do
            unless filters[:freeness].nil?
              with :freeness, filters[:freeness]
            end
            if filters[:university_type_id]
              with :university_type_id, filters[:university_type_id]
            end
            if filters[:city_ids] # array
              with :cities, filters[:city_ids]
            end
            if filters[:region_id] # array
              with :regions, filters[:region_id]
            end
        end
      end
      @results = result.results
      render json:@results, status:200


    #Carreers search
    elsif params[:carreer]
      filters = params[:carreer]
      # If no filters we do a regular query
      unless filters.size > 0
        render json:Carreer.all.includes(:campu,:weighing,:area,university: :institution,campu: :city).order("institutions.id ASC"), status:200
        return
      end
      result = Carreer.search(include:[:campu,:weighing,:area]) do
        paginate(page:params[:page] || 1 ,per_page: 20)
        order_by(:university_id,:asc)
        if filters[:text]
          fulltext filters[:text], fields:[:title,:university]
        end
        all_of do
          if filters[:city_id]
            with :city_id, filters[:city_id]
          end

          if filters[:region_id]
            with :region_id, filters[:region_id]
          end
          if filters[:cut]
            if filters[:cut][:min]
              with(:last_cut).greater_than(filters[:cut][:min] - 1)
            end
            if filters[:cut][:max]
              with(:last_cut).less_than(filters[:cut][:max] + 1)
            end
          end

          if filters[:semesters]

            if filters[:semesters][:min]
              with(:semesters).greater_than(filters[:semesters][:min] - 1)
            end
            if filters[:semesters][:max]
              with(:semesters).less_than(filters[:semesters][:max] + 1)
            end
          end

          if filters[:price]
            if filters[:price][:min]
              with(:price).greater_than(filters[:price][:min] - 1)
            end
            if filters[:price][:max]
              with(:price).less_than(filters[:price][:max] + 1)
            end
          end

          if filters[:area]
            with :area_id, filters[:area]
          end

          if filters[:schedule]
            with :schedule, filters[:schedule]
          end

          if filters[:employability]
            with(:employability).greater_than(filters[:employability] - 0.0002)
          end

          if filters[:income]
            with(:income).greater_than(filters[:income] - 1)
          end

          if filters[:university_id]
            with :university_id, filters[:university_id]
          end

        end
      end
      @results = result.results
      render json:@results, status:200

    # Bad params
    else
      render json:{errors:"no search params"}, status:422
    end
  end

end