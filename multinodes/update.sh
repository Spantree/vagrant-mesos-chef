cat "$2" | http PUT "http://marathon.mesos:8080/v2/apps/$1" "Content-Type: application/json"