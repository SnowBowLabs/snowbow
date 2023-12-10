import { ConnectWallet } from "@thirdweb-dev/react";
import styles from "../styles/Home.module.css";
import Image from "next/image";
import { NextPage } from "next";
import { Container, Flex, Stack, Heading, Button } from "@chakra-ui/react";
import NextLink from "next/link";

const Home: NextPage = () => {
    return (
        <Container maxW={"1200px"}>
            <Flex h={"80vh"} alignItems={"center"} justifyContent={"center"} >
                <Stack spacing={4} align={"center"}>
                    <Heading textAlign="center" as={"h1"} size={"4xl"} padding={"40px"}>
                        Higher yields in volatile market environments
                    </Heading>
                    <Button as={NextLink}
                        href='/products'
                        size="lg" // Predefined large size
                        sx={{
                            fontSize: '20px', // Custom font size
                            padding: '24px', // Custom padding
                        }}>LAUNCH</Button>

                </Stack>
            </Flex>

        </Container>
    );
};

export default Home;
