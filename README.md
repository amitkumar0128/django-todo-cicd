# 🐳 Django ToDo App - Dockerized

A simple Django ToDo application running with Docker. Just clone, configure, and run with one command !

## 🚀 What's Inside

- **Django 5.2** - Web application
- **MySQL** - Database
- **Nginx** - Web server
- **Docker Compose** - Orchestrates everything

## 📂 Project Structure

```
django-todo-docker/
├── docker-compose.yml    # Main Docker configuration
├── Dockerfile           # Django app container
├── nginx/
│   ├── Dockerfile         # Nginx container
│   └── default.conf       # Nginx configuration
├── todo_project/       # Django project files
├── todo/               # Todo App
├── requirements.txt    # Python dependencies
├── .env               # Environment variables
├── manage.py 
├── .gitignore
└── README.md
```

## ⚡ Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/amitkumar0128/django-todo-docker.git
cd django-todo-docker
```

### 2. Create `.env` file
```env
SECRET_KEY=your-secret-key-here
DEBUG=True
DB_NAME=todo_db
DB_USER=todo_user
DB_PASSWORD=supersecret123
DB_HOST=mysql
DB_PORT=3306
MYSQL_ROOT_PASSWORD=rootpassword123
```

### 3. Run the application
```bash
docker-compose up
```

That's it! 🎉

- **Application**: http://localhost
- **Admin Panel**: http://localhost/admin

## 🔧 Docker Skills Demonstrated

### Multi-Container Setup
- **3 containers** working together: Django app, MySQL database, Nginx proxy
- **Container networking** - services communicate internally
- **Volume persistence** - database data survives container restarts

### Production-Ready Configuration
- **Nginx reverse proxy** - handles static files and forwards requests
- **Gunicorn WSGI server** - runs Django in production mode
- **Environment variables** - secure configuration management
- **Health checks** - ensures services are running properly

### Docker Compose Features
```yaml
services:
  django:    # Web application
  mysql:     # Database
  nginx:     # Web server

volumes:
  mysql-data:    # Persistent database storage

networks:
  django-net:       # Internal container communication
```

## 🛠️ Useful Commands

### View running containers
```bash
docker-compose ps
```

### Check logs
```bash
docker-compose logs django
docker-compose logs mysql
```

### Create admin user
```bash
docker-compose exec django python manage.py createsuperuser
```

### Stop everything
```bash
docker-compose down
```

### Remove everything (including data)
```bash
docker-compose down -v
```

## 🏗️ How It Works

1. **Docker Compose** reads the configuration and starts 3 containers
2. **MySQL container** starts first and creates the database
3. **Django container** connects to MySQL and runs migrations
4. **Nginx container** starts and proxies requests to Django
5. All containers communicate through an internal Docker network

## 🔒 Environment Variables

The `.env` file keeps sensitive information secure:
- Database passwords
- Django secret key
- Debug settings
- Database connection details

## 📊 What You Learn

- **Docker containerization** - packaging applications
- **Multi-container orchestration** - making services work together
- **Environment configuration** - managing settings securely
- **Production deployment** - using proper web servers
- **Data persistence** - keeping database data safe

## 🚀 Next Steps

Once running, you can:
1. Add new ToDo items through the web interface
2. Manage data through Django admin panel
3. Modify code and see changes reflected
4. Scale services by adding more containers
5. Deploy to cloud platforms like AWS or DigitalOcean

---

**Perfect for**: Learning Docker, Django deployment, or showcasing containerization skills!
