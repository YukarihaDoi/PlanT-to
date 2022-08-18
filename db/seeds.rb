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
PostCategory.create!([{
  post_category: '野菜'
},
{
  post_category: '観葉植物'
}
])
QuestionCategory.create!([{
  question_category: '野菜'
},
{
  question_category: '観葉植物'
}
])