admin = User.create \
  email: 'admin@local.host',
  password: '123456', password_confirmation: '123456',
  profile: { bio: 'Director of Engagement & Analytics, GHM. Also co-Founder at SomeStartup' }
admin.grant! User::Roles::ADMIN
admin.grant! User::Roles::EDITOR

User.last.articles.create \
  title: "How To Pitch Journalists & Press – The Definitive Guide",
  text: "Conventional PR focuses too much on the pitching process. I’ve seen countless marketers obsess over subject lines and salutations. While that is still crucial, for truly outstanding PR results, you have to think about your entire content-to-pitch process.",
  tags: ['pr', 'pitching']
