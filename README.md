:briefcase::briefcase::briefcase:MUSE JOBS API:briefcase::briefcase::briefcase:


## Rake Tasks

| Command  | Description |
| ------------- | ------------- |
| db:seed_muse_data  | loads in company and jobs into the db from the Muse API |


# Routes

### Companies

| VERB  | Route | Description | Params |
| ------------- | ------------- | ------------- | ------------- |
| GET  |  [localhost:3000/v1/companies](http://localhost:3000/v1/companies)  | List of all companies paginated with count of jobs | page=[number=[:page_number]], fields=[:field_name_1,field_name_2] |    
| GET  |  [localhost:3000/v1/companies/[:id]](http://localhost:3000/v1/companies/1)  | List single company |  |            

### Jobs

| VERB  | Route | Description | Params |
| ------------- | ------------- | ------------- | ------------- |
| GET  |  [localhost:3000/v1/jobs](http://localhost:3000/v1/jobs)  | List of all jobs paginated with short company info | page=[number=[:page_number]], include_unpublished=true, fields=[:field_name_1,field_name_2] |         
ex. http://localhost:3000/v1/jobs?include_unpublished=true&levels[]=entry&levels[]=mid  
ex. http://localhost:3000/v1/jobs?include_unpublished=true&categories[]=Human%20Resources&categories[]=Sales&locations[]=Hong%20Kong

| GET  |  [localhost:3000/v1/jobs/[:id]](http://localhost:3000/v1/jobs/1)  | List single job |  |            
