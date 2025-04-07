#!/bin/bash

#!/bin/bash

sudo hostnamectl set-hostname EC2-Amamzon-Linux
sudo su - ec2-user

sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl status httpd

# Create the index.html file in the web root
sudo tee /var/www/html/index.html > /dev/null << 'EOT'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
        }
        
        header {
            background: #35424a;
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        main {
            padding: 20px 0;
        }
        
        section {
            margin-bottom: 20px;
            padding: 20px;
            background: white;
            border-radius: 5px;
        }
        
        footer {
            background: #35424a;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>Welcome to My Website</h1>
            <p>A simple and clean HTML template</p>
        </div>
    </header>

    <div class="container">
        <main>
            <section>
                <h2>About Us</h2>
                <p>This is a basic HTML template for your website. You can customize this content to suit your needs.</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras porttitor metus in nibh finibus, vel eleifend mi pretium.</p>
            </section>
            
            <section>
                <h2>Our Services</h2>
                <p>Here are some services we offer:</p>
                <ul>
                    <li>Web Design</li>
                    <li>Content Creation</li>
                    <li>SEO Optimization</li>
                    <li>Social Media Marketing</li>
                </ul>
            </section>
            
            <section>
                <h2>Contact Us</h2>
                <p>Feel free to get in touch with us:</p>
                <p>Email: example@email.com</p>
                <p>Phone: (123) 456-7890</p>
                <p>Address: 123 Main Street, Anytown, USA</p>
            </section>
        </main>
    </div>

    <footer>
        <div class="container">
            <p>&copy; 2025 My Website. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
EOT

# Ensure proper permissions
sudo chmod 644 /var/www/html/index.html

# Restart Apache to apply changes
sudo systemctl restart httpd

echo "Setup complete! Your web server is now running with the custom index.html file."