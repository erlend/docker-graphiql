GraphiQL
========

A tiny [GraphiQL](https://github.com/graphql/graphiql/tree/master/packages/graphiql#readme) docker image.

Usage
-----

### Example

    docker run -p 8080:80 erlend/graphiql

### Environment variables

| Variable name    | Description                 | Default                  |
| ---------------- | --------------------------- | ------------------------ |
| `GRAPHIQL_API`   | GraphQL API to connect to   | https://swapi.graph.cool |
| `GRAPHIQL_THEME` | Theme for CodeMirror editor | graphiql                 |
