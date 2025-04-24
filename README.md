# step 1:
 in zilliz project, prepare a service account
`terraform apply -auto-approve`

#step 2:
 in customer project
 - prepare a service account which have some permission to do something(like create a bucket) 
 - allow service account from zilliz project to impersonate it
`terraform apply -auto-approve`

#step 3:
 use service account in zilliz project impersonate the service account customer project to create a bucket
`terraform apply -auto-approve`

