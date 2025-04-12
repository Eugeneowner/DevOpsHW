#!/bin/bash

yum update -y
yum install -y nginx

ip=$(curl -s http://checkip.amazonaws.com)

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Welcome Page</title>
  <style>
    body {
      background: #f9f9f9;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      text-align: center;
      padding-top: 60px;
    }
    h1 {
      font-size: 36px;
      color: #333;
      margin-bottom: 10px;
    }
    .highlight {
      color: #007acc;
      font-weight: bold;
    }
    .ip {
      margin-top: 30px;
      font-size: 20px;
    }
    .ip span {
      color: #e74c3c;
    }
  </style>
</head>
<body>
  <h1 class="highlight">🚀 Welcome to the Cloud, Eugene! 🚀</h1>
  <h1>Hello 👋</h1>
  <h1>Welcome to your homework!</h1>
  <h1>And finally, Goodbye 👋</h1>
  <div class="ip">
    Server Public IP: <span>$ip</span>
  </div>
</body>
</html>
EOF

systemctl enable nginx
systemctl start nginx