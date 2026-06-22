# エコキュート（ヒートポンプ式給湯器）のスペック。貯湯量と最大電流を持つ。
# 表示用の種別名は model_name.human（config/locales/ja.yml の activerecord.models）で取得する。
class EcoCute < ApplicationRecord
  include Heaterable
end
