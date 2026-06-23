require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  # delegated_type が機能していれば、製品ごとに render product.heater が
  # 正しい種別のパーシャルへ委譲され、その種別固有の項目「だけ」が表示される。
  test "各製品が種別に応じた項目を表示する（delegated_type が正しく委譲している）" do
    visit root_path
    assert_selector "h1", text: "製品一覧"

    # ガス給湯器: ガス固有の項目だけが出る
    within product_card("GX-24") do
      assert_text "ガス給湯器"
      assert_text "対応ガス種"
      assert_text "都市ガス"      # gas_type enum を i18n で表示
      assert_text "ガス消費量"
      assert_text "30500kcal/h"
      assert_no_text "対応燃料種"  # 石油給湯器の項目は出ない
      assert_no_text "貯湯量"      # エコキュートの項目は出ない
    end

    # 石油給湯器: 石油固有の項目だけが出る
    within product_card("OL-46") do
      assert_text "石油給湯器"
      assert_text "対応燃料種"
      assert_text "灯油"          # fuel_type enum を i18n で表示
      assert_text "燃料消費"
      assert_text "4.1L/h"
      assert_no_text "対応ガス種"
      assert_no_text "最大電流"
    end

    # エコキュート: エコキュート固有の項目だけが出る
    within product_card("EQ-370") do
      assert_text "エコキュート"
      assert_text "貯湯量"
      assert_text "370L"
      assert_text "最大電流"
      assert_text "18A"
      assert_no_text "対応ガス種"
      assert_no_text "対応燃料種"
    end
  end

  private

  # 製品名を含むカード（li）にスコープする
  def product_card(name)
    find("li", text: name)
  end
end
