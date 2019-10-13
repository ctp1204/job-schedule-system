password = "123123"
admin = User.create(username: "Admin" , email: "admin@gmail.com" , password: password , password_confirmation: password, role: 2)
leader = User.create(username: "Leader" , email: "leader@gmail.com" , password: password , password_confirmation: password, role: 2)
user = User.create(username: "User" , email: "user@gmail.com" , password: password , password_confirmation: password)
user = User.create(username: "CuongTanPhu" , email: "ctp1204@gmail.com" , password: password , password_confirmation: password)
