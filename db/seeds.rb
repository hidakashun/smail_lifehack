# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

#user1~20のデータ
20.times do |n|
  User.create!(
    account_name: "テストユーザー#{n + 1}",
    is_active: false,
    email: "test#{n + 1}@test.com",
    introduction: "私はテストユーザー#{n + 1}といいます。よろしくお願いします。",
    password: "000000"
  )
end

puts " user1~20のデータ作成完了"

#user21~23のデータ
user_data = [
  { email: ENV['USER_EMAIL21'], account_name: "テスト21", is_active: true, password: ENV['USER_PASSWORD21'] },
  { email: ENV['USER_EMAIL22'], account_name: "テスト22", is_active: true, password: ENV['USER_PASSWORD22'] },
  { email: ENV['USER_EMAIL23'], account_name: "テスト23", is_active: true, password: ENV['USER_PASSWORD23'] }
]

user_data.each do |data|
  User.find_or_create_by!(email: data[:email]) do |user|
    user.account_name = data[:account_name]
    user.is_active = data[:is_active]
    user.password = data[:password]
  end
end

puts " user21~23のデータ作成完了"

#adminのデータ
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

puts " adminのデータ作成完了"

#ユーザー投稿関連
User.all.each do |user|
  user.lifehacks.create!(
      [
    {
      title: "タイトルは２０文字以内で投稿可能です。",
      body: "本文は２００文字以内で投稿可能です。テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト",
      tag: "テストタグ"
    },
    {
      title: "夏場のエアコン",
      body: "夏場のエアコンは、こまめに切るよりつけっぱなしにしていたほうが電気代がかからない。日中9:00～18:00の時間帯は、30分間であればエアコンを切るより、「つけっぱなし」にするほうが消費電力量は少なかった。",
      tag: "節約"
    },
    {
      title: "ラップパックで洗剤の浸透率をアップ",
      body: "落ちにくいカビや頑固な汚れには、ラップパックがおすすめ！ラップパックの方法は、汚れが気になる部分に洗剤をかけて、キッチンペーパーを乗せてラップで密封するだけと簡単です。洗面台の鏡やシンク、油汚れが飛び散ったキッチンの壁などにおすすめの掃除方法です。",
      tag: "掃除"
    },
    {
      title: "蛇口の水垢とり",
      body: "蛇口などについた頑固な水垢を落とすのにをみかんの皮をこすりつけてみる。みかんの皮にはリモネンに加え、クエン酸も含まれています。内側の白い部分でシンクや水道の蛇口を磨くと酸が水垢を溶かし、落としやすくします。",
      tag: "掃除"
    }
  ]
)

  user.lifehacks.each do |lifehack|

  #いいね数をランダムで作成
    rand(1..15).times do# 1から15までのランダムなユーザーがいいね数を設定
      Favorite.create(user: User.all.sample, lifehack: lifehack)
    end
  end

  #投稿に対してのコメントをランダムで作成
  Lifehack.all.sample(5).each do |lifehack|
    LifehackComment.create(
      user: user,
      lifehack: lifehack,
      comment: "これは素晴らしいライフハックですね！"
    )
  end

  #オススメ度
  lifehacks = Lifehack.all
  lifehacks.each do |lifehack|
    lifehack.update(star: rand(1..5)) # 1から5までのランダムなおすすめ度を設定
  end

  # ここで画像をアップロードして関連付ける
  lifehack1 = user.lifehacks.last#ユーザーの最新の投稿
  lifehack2 = user.lifehacks[-2]#ユーザーの最新のひとつ前の投稿
  lifehack3 = user.lifehacks[-3]#ユーザーの最新のふたつ前の投稿

  # 画像を複数アップロードする場合、同様のコードを繰り返し使用
  lifehack1.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/mandarin orange.jpg"), filename:"mandarin orange.jpg")
  lifehack1.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/faucet1.jpg"), filename:"faucet1.jpg")
  lifehack1.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/faucet2.jpg"), filename:"faucet2.jpg")

  # 画像を複数アップロードする場合、同様のコードを繰り返し使用
  lifehack2.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/Rappu pack1.jpg"), filename:"Rappu pack1.jpg")
  lifehack2.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/Rappu pack2.jpg"), filename:"Rappu pack1.jpg")
  lifehack2.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/Rappu pack3.jpg"), filename:"Rappu pack3.jpg")

  # 画像を複数アップロードする場合、同様のコードを繰り返し使用
  lifehack3.lifehack_images.attach(io: File.open("#{Rails.root}/db/fixtures/air conditioner.jpg"), filename:"air conditioner.jpg")
end

puts "userの投稿データ問題なく作成されました。"

puts "seedの実行が完了しました"