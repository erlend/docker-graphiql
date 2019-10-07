ARG VERSION="0.15.1"

FROM node as graphiql
ARG VERSION
RUN wget https://github.com/graphql/graphiql/archive/graphiql@$VERSION.tar.gz -O- | tar zx
WORKDIR /graphiql-graphiql-$VERSION
RUN yarn && yarn build

FROM alpine as thttpd
RUN apk add --no-cache thttpd

FROM scratch
ARG VERSION
ENV GRAPHIQL_API="https://swapi.graph.cool" 
ENV GRAPHIQL_THEME="graphiql"
ENV PATH="/bin"
COPY entrypoint.sh /entrypoint.sh
COPY --from=thttpd /etc/passwd /etc/passwd
COPY --from=thttpd /bin/busybox /bin/busybox
COPY --from=thttpd /usr/sbin/thttpd /bin/thttpd
COPY --from=thttpd /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=graphiql /graphiql-graphiql-$VERSION/packages/graphiql-examples/cdn/images/logo.svg /www/images/logo.svg
COPY --from=graphiql /graphiql-graphiql-$VERSION/packages/graphiql/graphiql.js /www/graphiql.js
COPY --from=graphiql /graphiql-graphiql-$VERSION/packages/graphiql/graphiql.css /www/graphiql.css

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-d", "/www"]
