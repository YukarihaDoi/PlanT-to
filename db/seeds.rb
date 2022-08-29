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

NewsImage.create!([{
  news_title: '秋間近！秋の花を探してみませんか？',
  news_body: '秋と言ったらどんな花を思い浮かべますか？'
  },
  {
  news_title: 'アップデートを行いました',
  news_body: '新しく〇〇機能が追加されました'
  }
  ])

PostCategory.create!([{
  post_category: '園芸日記'
},
{
  post_category: '質問・相談'
},
{
  post_category: '宣伝'
},
{
  post_category: 'その他'
}
])


User.create!([{
  email: 'Engei@shoshinsya',
  password: 'engeisyoshinsya',
  name: '園芸初心者',
  profile_image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./db/fixtures/images/Leaf.jpg")),filename: 'Leaf.jpg' )
},

{
 email: 'yasai831@nouka',
  password: 'yasai831831',
  name: '農家のおじちゃん',
  profile_image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/tomato.jpg")),filename: 'tomato.jpg' )
},

{
  email: 'hanagasuki@8787',
  password: '8787suki',
  name: 'HanaYamamoto',
  profile_image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/asagao.jpg")),filename: 'asagao.jpg' )

}
])

PostImage.create!([{
  user_id: 1,
  post_category_id: 1,
  title: '園芸始めました',
  body: '観葉植物を買いました#ハルオチア',
  image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/haruotia.jpg")),filename: 'haruotia.jpg' )
},
{
  user_id: 2,
  post_category_id: 1,
  title: '黄色のトマト',
  body: '今年は黄色のトマトも植えました。大変美味しそうです。たくさんできたので親戚に #お裾分け するぞ！',
  image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/tomato.jpg")),filename: 'tomato.jpg' )
},
{
  user_id: 3,
  post_category_id: 3,
  title: '新しい植木、入荷しました',
  body: '#山形 で #花屋 を経営しています！買いたい人はお気軽にお問い合わせください！',
  image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/uekibati.jpg")),filename: 'uekibati.jpg' )
},
{
  user_id: 1,
  post_category_id: 2,
  title: 'この植物の #名前 について教えてください',
  body: '名前がわかりません',
  image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/humei.jpg")),filename: 'humei.jpg' )
},
{
  user_id: 2,
  post_category_id: 3,
  title: '朝市始めました',
  body: '早起きして買いに来てくれー #朝市'
},
{
  user_id: 3,
  post_category_id: 4,
  title: 'アルバイト募集！',
  body: '#花屋 で働きませんか？ #アルバイト',
  image: ActiveStorage::Blob.create_and_upload!(io:File.open(Rails.root.join("./app/assets/plants_images/green_necklace.jpg")),filename: 'green_necklace.jpg' )
},
{
  user_id: 1,
  post_category_id: 2,
  title: 'もう一つ植物を買いたい',
  body: 'おすすめありますか？'
}
])