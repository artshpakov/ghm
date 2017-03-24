admin = User.create email: 'admin@local.host', password: '123456', password_confirmation: '123456'
admin.grant! Roles::ADMIN
