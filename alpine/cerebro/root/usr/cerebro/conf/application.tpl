# Secret will be used to sign session cookies, CSRF tokens and for other encryption utilities.
# It is highly recommended to change this value before running cerebro in production.
secret = "ki:s:[[@=Ag?QI`W2jMwkY:eqvrJ]JqoJyi2axj3ZvOv^/KavOT4ViJSv?6YY4[N"

# Application base path
basePath = "/"

# Defaults to RUNNING_PID at the root directory of the app.
# To avoid creating a PID file set this value to /dev/null
pidfile.path=/dev/null

# Rest request history max size per user
rest.history.size = 50 // defaults to 50 if not specified

# Path of local database file
data.path = "./cerebro.db"

es = {
  gzip = true
}

# Authentication
auth = {
  type: basic
    settings: {
      username = "${CEREBRO_USERNAME}"
      password = "${CEREBRO_PASSWORD}"
    }
}

# A list of known hosts
hosts = [
  {
    host = "http://${ES_HOST}:${ES_PORT}"
    name = "Elastic"
  },
]