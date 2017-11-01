require "Edamam"

def edamam
  @recipe = Edamam.list_recipes(params[:uri], params[:label], params[:image], params[:url], params[:calories], params[:ingredients])
end
