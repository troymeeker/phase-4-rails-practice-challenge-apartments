class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    

    def index
     render json: Tenant.all
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant
    end

  
    def update
        tenant = find_tenant
        render json: tenant.update(tenant_params), status: :updated

    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content

    end

    private 

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
       Tenant.find(params[:id])
    end

    def render_unprocessable_entity_response
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: {error: "Not found"}, status: :not_found

    end

end
