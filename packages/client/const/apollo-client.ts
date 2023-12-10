// apollo-client.js
import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client';

const client = new ApolloClient({
    link: new HttpLink({
        uri: 'https://api.thegraph.com/subgraphs/name/snowbowlabs/snowbow-subgraph', // Replace with your GraphQL API endpoint
    }),
    cache: new InMemoryCache(),
});

export default client;
