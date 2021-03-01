# README

O projeto Manage-API inicialmente, serve para cadastrar empresas diversas, assim como seus contatos e endereços.
OBS.: O projeto ainda esta em fase de desenvolvimento e refatoração.

Atualmente contamos com os seguintes endpoints com CRUD:

- http://localhost:3000/api/v1/customers
- http://localhost:3000/api/v1/facilities
- http://localhost:3000/api/v1/contacts

Para rodar a API é necessário os seguintes:
- configurar o banco de dados;
- rodar: rails db:create db:migrate
- rails s
- acessar o swagger (http://localhost:3000/api-docs/index.html)
