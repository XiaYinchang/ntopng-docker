#!/bin/bash
curl -XPUT 192.168.2.18:9200/_template/ntopng -d '
{
  "template" : "ntopng-*",
  "settings" : {
    "index.refresh_interval" : "5s"
  },
  "mappings" : {
    "_default_" : {
       "_all" : {"enabled" : true, "omit_norms" : true},
       "dynamic_templates" : [ {
             "string_fields" : {
               "match" : "*",
               "match_mapping_type" : "string",
               "mapping" : {
                 "type" : "string", "index" : "analyzed", "omit_norms" : true,
                   "fields" : {
                     "raw" : {"type": "string", "index" : "not_analyzed", "ignore_above" : 256}
                   }
               }
             }
       }, {
             "geo_fields" : {
               "match" : "*_IP_LOCATION",
               "mapping": {
                      "type": "geo_point"
                }
             }
       }, {
             "ip_fields" : {
               "match" : "IPV4_*",
               "match_mapping_type" : "string",
               "mapping": {
                      "type": "ip"
                }
             }
       } ],
       "properties" : {
          "@version": { "type": "string", "index": "not_analyzed" },
          "IPV4_DST_ADDR": {
            "type": "ip",
            "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 128
                }
            }
          },
          "IPV4_SRC_ADDR": {
            "type": "ip",
            "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 128
                }
            }
          }
       }
    }
  }
}'
