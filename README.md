Container for Cloudera Manager basic
start the container by

sudo docker run -it --name cm_server --link mysql_container:cmdb -p 7180:7180
