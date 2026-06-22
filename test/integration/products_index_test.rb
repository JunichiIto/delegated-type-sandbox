require "test_helper"

class ProductsIndexTest < ActionDispatch::IntegrationTest
  test "製品一覧に3種すべての製品が種別名・固有項目つきで表示される" do
    get root_path

    assert_response :success
    assert_select "h1", /製品一覧/

    # 製品名（型名を含まない）
    assert_select "h2", "GX-24"
    assert_select "h2", "OL-46"
    assert_select "h2", "EQ-370"

    # 種別名はビュー側（type_label）で付与される
    assert_select "span", "ガス給湯器"
    assert_select "span", "石油給湯器"
    assert_select "span", "エコキュート"

    # 種別ごとの固有項目（単位はビューで付与）
    assert_select "dd", "都市ガス"   # gas_type enum を i18n で表示
    assert_select "dd", "30500kcal/h"
    assert_select "dd", "灯油"   # fuel_type enum を i18n で表示
    assert_select "dd", "4.1L/h"
    assert_select "dd", "370L"
    assert_select "dd", "18A"
  end
end
