# Genpagx

## Acessando a API online

A API está disponível no endereço abaixo:

[genpagx.gigalixirapp.com/api](https://genpagx.gigalixirapp.com/api)

## Rodando localmente

Com a intenção de facilitar a iniclização e o uso da aplicação localmente, criei um setup com Docker.
Para iniciar basta ter o docker e o docker-compose instalados na sua máquina, dessa forma você tera um container Elixir/Phoenix com a aplicação e um database PostgreSQL rodando localmente.
Execute o comando abaixo e aguarde os logs mais abaixo aparecerem em seu terminal.

```bash
docker-compose up
```

```
genpagx    | [info] Access GenpagxWeb.Endpoint at http://localhost:4000
genpagx    | [info] GET /api/accounts
```

Com esas informações em tela a sua aplicação estará funcionando e pronto para o acesso.
## Postman collection

Caso você utilize o Postman como interface para enviar requisições para API's, basta acessar o link abaixo que você terá acesso a uma coleção de requisições tanto no ambiente de produção quanto do de desenvolvimento.

### [Genpagx Public Workspace Postman](https://www.postman.com/restless-capsule-16017/workspace/d8442359-86e8-4f0b-9f9a-dee0db1716e6)
