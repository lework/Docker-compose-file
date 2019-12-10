#!/bin/bash


exec="docker-compose -f docker-compose-cluster.yml exec rmq0"


# queue
echo "__create queue________"
$exec rabbitmqadmin declare queue --vhost=/ name=ha1.queue durable=true
$exec rabbitmqadmin declare queue --vhost=/ name=ha2.queue durable=true
$exec rabbitmqadmin declare queue --vhost=/ name=ha3.queue durable=true
$exec rabbitmqadmin declare queue --vhost=/ name=all.queue
$exec rabbitmqadmin declare queue --vhost=/ name=nodes.queue


# exchange
echo "__create exchange________"
$exec rabbitmqadmin declare exchange --vhost=/ name=test.exchange type=direct durable=true

# binding 

$exec rabbitmqadmin declare binding --vhost=/ source=test.exchange destination=ha1.queue routing_key=ha1.queue
$exec rabbitmqadmin declare binding --vhost=/ source=test.exchange destination=ha2.queue routing_key=ha2.queue
$exec rabbitmqadmin declare binding --vhost=/ source=test.exchange destination=ha3.queue routing_key=ha3.queue

# list

echo "__queues___________________"
$exec rabbitmqctl list_queues -p /
echo "__exchanges___________________"
$exec rabbitmqctl list_exchanges -p /
echo "__bindings___________________"
$exec rabbitmqctl list_bindings -p /

# send message
echo "__send message________"
$exec rabbitmqadmin publish routing_key=ha1.queue payload="just for queue"
$exec rabbitmqadmin publish exchange=test.exchange routing_key=ha1.queue payload="hello, world"

echo "__get queue________"
$exec rabbitmqadmin get queue=ha1.queue

# consumer
echo "__consumer message_______"
$exec rabbitmqadmin get queue=ha1.queue ackmode=ack_requeue_false
$exec rabbitmqadmin get queue=ha1.queue ackmode=ack_requeue_false
echo "__queue message______________"
$exec rabbitmqadmin get queue=ha1.queue

