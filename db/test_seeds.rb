UserType.create(name: 'Admin')

User.create(name: 'SuperAdmin', username: 'superAdmin', email: 'super.admin@gmail.com', password: 'veryStrongPassword', user_type_id: 1)
