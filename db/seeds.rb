# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'test@test.com',
  password: 'test01')

User.create!(
  email: 'tomato@tomato',
  password: 'tomato10',
  name: 'トマト')
NewsImage.create!(
  news_title: '秋間近！秋の花を探してみませんか？',
  news_body: '秋と言ったらどんな花を思い浮かべますか？'
  )

PostCategory.create!([{
  post_category: '野菜'
},
{
  post_category: '観葉植物'
},
{
  post_category: '花'
}
])
QuestionCategory.create!([{
  question_category: '水やり'
},
{
  question_category: '肥料'
}
])