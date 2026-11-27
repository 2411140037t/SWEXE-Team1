# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 猫の特徴タグ（何回実行しても重複しない）
# [カテゴリ, 名前, チップの丸の色]
TAGS = [
  [ "pattern", "キジトラ", "#8B6B4A" ],
  [ "pattern", "茶トラ", "#E8913A" ],
  [ "pattern", "サバトラ", "#8E9AA6" ],
  [ "pattern", "三毛", "#F2C38B" ],
  [ "pattern", "サビ", "#5A3B2E" ],
  [ "pattern", "黒", "#222222" ],
  [ "pattern", "白", "#FFFFFF" ],
  [ "pattern", "グレー", "#9E9E9E" ],
  [ "pattern", "ハチワレ", "#444444" ],
  [ "pattern", "その他", nil ],
  [ "coat_length", "短毛", nil ],
  [ "coat_length", "長毛", nil ],
  [ "age", "子猫", nil ],
  [ "age", "成猫", nil ],
  [ "age", "わからない", nil ],
  [ "collar", "あり", nil ],
  [ "collar", "なし", nil ],
  [ "collar", "わからない", nil ],
  [ "condition", "怪我あり", nil ],
  [ "condition", "やせている", nil ],
  [ "condition", "人なれしている", nil ]
].freeze

TAGS.each_with_index do |(category, name, color), index|
  tag = Tag.find_or_initialize_by(category: category, name: name)
  tag.update!(color: color, position: index)
end
