import { Avatar, Box, Flex, Heading, Link, Text } from "@chakra-ui/react";
import { ConnectWallet, useAddress } from "@thirdweb-dev/react";
import NextLink from "next/link";

export function Navbar() {
    const address = useAddress();

    return (
        <Box maxW={"1200px"} mx={"auto"} px={"10px"} py={"40px"}>
            <Flex justifyContent={"space-between"} alignItems={"center"}>
                <Link as={NextLink} href='/'>
                    <Heading>SnowBowLab</Heading>
                </Link>
                <Flex direction={"row"}>
                    <Link as={NextLink} href='/portfolio' mx={2.5}>
                        <Text>PORTFOLIO</Text>
                    </Link>
                    <Link as={NextLink} href='/docs' mx={2.5}>
                        <Text>DOCS</Text>
                    </Link>
                </Flex>
                <Flex dir={"row"} alignItems={"center"}>
                    <ConnectWallet theme="light" />

                </Flex>
            </Flex>
        </Box>

    );

}