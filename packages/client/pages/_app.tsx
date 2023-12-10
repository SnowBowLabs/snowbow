import type { AppProps } from "next/app";
import { ThirdwebProvider } from "@thirdweb-dev/react";
import "../styles/globals.css";
import { ChakraProvider } from "@chakra-ui/react";
import { Navbar } from "../components/Navbar";
import { ApolloProvider } from '@apollo/client';
import client from '../const/apollo-client'; // Adjust the import path to where your Apollo Client instance is created
// This is the chain your dApp will work on.
// Change this to the chain your app is built for.
// You can also import additional chains from `@thirdweb-dev/chains` and pass them directly.
const activeChain = "mumbai";

function MyApp({ Component, pageProps }: AppProps) {
    return (
        <ThirdwebProvider
            clientId={process.env.NEXT_PUBLIC_TEMPLATE_CLIENT_ID}
            activeChain={activeChain}
        >
            <ChakraProvider>
                <ApolloProvider client={client}>
                    <Navbar />
                    <Component {...pageProps} />
                </ApolloProvider>
            </ChakraProvider>
        </ThirdwebProvider>
    );
}

export default MyApp;
