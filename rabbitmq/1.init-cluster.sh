#!/bin/bash


exec="docker-compose -f docker-compose-cluster.yml exec"


# rmq1,内存节点

$exec rmq1 rabbitmqctl stop_app # 停止rabbitmq服务
$exec rmq1 rabbitmqctl reset # 清空节点状态
$exec rmq1 rabbitmqctl join_cluster --ram rabbit@rmq0 # rmq1和rmq0构成集群,rmq1必须能通过rmq0的主机名ping通
$exec rmq1 rabbitmqctl start_app  # 开启rabbitmq服务

# rmq2,内存节点

$exec rmq2 rabbitmqctl stop_app # 停止rabbitmq服务
$exec rmq2 rabbitmqctl reset # 清空节点状态
$exec rmq2 rabbitmqctl join_cluster --ram rabbit@rmq0 # rmq2和rmq0构成集群,rmq2必须能通过rmq0的主机名ping通
$exec rmq2 rabbitmqctl start_app  # 开启rabbitmq服务


$exec rmq0 rabbitmqctl cluster_status
