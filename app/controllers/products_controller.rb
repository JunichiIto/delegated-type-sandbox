class ProductsController < ApplicationController
  # 製品一覧。発売日順に並べる。
  # includes(:heater) で委譲先（GasWaterHeater / OilWaterHeater / EcoCute）をまとめて読み込む。
  def index
    @products = Product.includes(:heater).order(:released_on)
  end
end
