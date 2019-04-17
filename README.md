:briefcase::briefcase::briefcase:MUSE JOBS API:briefcase::briefcase::briefcase:


## Rake Tasks

| Command  | Description |
| ------------- | ------------- |
| db:seed_muse_data  | loads in company and jobs into the db from the Muse API |


# Routes

### Companies

| VERB  | Route | Description | Params |
| ------------- | ------------- | ------------- | ------------- |
| GET  |  [localhost:3000/v1/companies](http://localhost:3000/v1/companies)  | List of all companies paginated with count of jobs ) | page=[number=[:page_number]], include=[nested_resource_1,nested_resource_2], fields=[:field_name_1,field_name_2] |      


### Jobs

| VERB  | Route | Description | Params |
| ------------- | ------------- | ------------- | ------------- |
| GET  |  [localhost:3000/v1/jobs](http://localhost:3000/v1/jobs)  | List of all jobs paginated with short company info ) | page=[number=[:page_number]], include=[nested_resource_1,nested_resource_2], fields=[:field_name_1,field_name_2] |      
