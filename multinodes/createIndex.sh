curl -XDELETE http://slave1:9200/shakespeare
curl -XPUT http://slave1:9200/shakespeare -d '
{
 "mappings" : {
  "_default_" : {
   "properties" : {
    "play_name" : {"type": "string", "index" : "not_analyzed" },
    "line_id" : { "type" : "integer" },
    "speech_number" : { "type" : "integer" }
   }
  }
 }
}
'
curl -XPUT slave1:9200/_bulk --data-binary @shakespeare.json > /dev/null