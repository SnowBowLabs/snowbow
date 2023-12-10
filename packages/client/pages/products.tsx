// pages/products.tsx
import { Link, Box, Flex, Text, Image, Button, VStack, HStack, Badge } from '@chakra-ui/react';
import NextLink from "next/link";

const ProductsPage = () => {
    const products = [
        {
            id: 1,
            name: 'Bullish Snowball',
            apy: '18%',
            description: 'UP TO 18% Fixed APY', // Adjust the XX% to match the actual APY you've provided
            underlyingAsset: 'USDC',
            duration: '28 Days',
            imageUrl: '/images/bullishSnowball.png', // Replace with the path to your image
            productTVL: '9,018,623.78',
            pageUrl: '/bullish-snowball', // Replace with the path to your product page
        },
        {
            id: 2, // Corrected ID for the second product
            name: 'Bearish Snowball',
            apy: '19%',
            description: 'UP TO 19% Fixed APY', // Adjust the XX% to match the actual APY you've provided
            underlyingAsset: 'wBTC',
            duration: '28 Days',
            imageUrl: '/images/bearishSnowball.png', // Replace with the path to your image
            productTVL: '9,018,623.78',
            pageUrl: '/bearish-snowball', // Replace with the path to your product page

        },
        // ... add more products as needed
    ];

    return (
        <Box p={4}>
            <Flex direction="column" align="center" m={4}>
                <Text fontSize="4xl" fontWeight="bold" padding={"10px"}>Products</Text>
                <Text fontSize="lg" >SnowBowLabs offers decentralized SnowBall exotic options, generating safer and higher yield.</Text>
                <Text fontSize="1xl" fontWeight="semibold" my={4} >TOTAL VALUE LOCKED (USDC)</Text>
                <Text fontSize="2xl" fontWeight="bold" >9,018,623.78</Text>

                <HStack spacing={4} mt={4} wrap="wrap" justify="center" padding={"20px"}>
                    {products.map((product) => (
                        <VStack key={product.id} p={4} borderWidth="1px" borderRadius="lg" m={2} spacing={3}>
                            <Image src={"https://cryptologos.cc/logos/polygon-matic-logo.svg?v=029"} alt="Polygon Logo" boxSize="20px" />
                            <Image src={product.imageUrl} alt={product.name} boxSize="200px" />
                            <Text fontSize="xl" fontWeight="bold">{product.name}</Text>
                            <Badge colorScheme="green">{product.apy} FIXED APY</Badge>
                            {/* <Text textAlign="center">{product.description}</Text> */}
                            <Text fontSize="sm">{`Duration: ${product.duration}`}</Text>
                            <Text fontSize="sm">{`Underlying Asset: ${product.underlyingAsset}`}</Text>
                            <Text fontSize="sm">{`Total Value Locked: ${product.productTVL}`}</Text>
                            <Link as={NextLink} href={product.pageUrl}>
                                <Button colorScheme="blue">Choose Option</Button>
                            </Link>
                        </VStack>
                    ))}
                </HStack>
            </Flex>
        </Box >
    );
};

export default ProductsPage;
