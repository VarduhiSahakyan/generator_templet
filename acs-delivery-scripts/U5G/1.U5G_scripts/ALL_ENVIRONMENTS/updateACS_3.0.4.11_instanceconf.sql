-- update elastic queries version to build reports
update `InstanceConfiguration` set value = 'v1' where name = 'ELASTIC_QUERIES_VERSION'
