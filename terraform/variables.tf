# Variables
variable "github_repo_url" {
  description = "Public GitHub repo to clone containing a Jenkinsfile"
  type        = string
  default     = "https://github.com/amitkumar0128/django-todo-docker.git"
}

variable "github_repo_name" {
  description = "Public GitHub repo name"
  type        = string
  default     = "django-todo-docker"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "todo-app-key"
}