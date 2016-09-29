# Elasticsearch 集群

## 常用命令
```
# 创建spark索引
curl -XPUT 'http://localhost:9200/spark/logs' -d '{"date": "2014-08-01T03:27:33.730Z","ip": "31.215.117.0","domain":"event.apiv8.com","offer_id":"123"}'
# 查询结构
curl 'http://localhost:9200/spark/_mapping/logs?pretty'
# 查询spark中的数据
curl 'localhost:9200/spark/logs/_search?pretty=true'
# 删除spark中的数据
curl -XDELETE 'http://localhost:9200/spark'
# 查询所有的index, type
curl 'localhost:9200/_search?pretty=true'
# 查询某个index下所有的type
curl 'localhost:9200/spark/_search?pretty=true'
# 查询某个index下,某个type下所有的记录
curl 'localhost:9200/spark/logs/_search?pretty=true'
# 带有参数的查询
curl 'http://localhost:9200/spark/logs/_search?q='event.apiv8.com'&pretty'
# 使用JSON参数的查询
curl localhost:9200/spark/_search -d ' 
{"query" : { "term": { "tag":"bad"}}}'
```