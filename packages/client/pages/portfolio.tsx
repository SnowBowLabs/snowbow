// pages/portfolio.tsx
import React, { useEffect, useState } from 'react';
import { useQuery } from '@apollo/client';
import { Box, Flex, VStack, Heading, Text, SimpleGrid, Card, Image } from '@chakra-ui/react';
import { ConnectWallet, useAddress } from '@thirdweb-dev/react';
import { GET_USER_PORTFOLIO } from '../components/queries'; // Adjust the import path
import { Stat, StatLabel, StatNumber, StatHelpText, StatArrow, useColorModeValue } from '@chakra-ui/react';
import { SNOWBOW_PRODUCT_ADDRESS } from '../const/addresses';
import { Web3Button } from "@thirdweb-dev/react";
import {
    SNOWBOW_PRODUCT_ABI
} from '../const/abi';

const PortfolioPage = () => {
    const address = useAddress();
    const { loading, error, data, refetch } = useQuery(GET_USER_PORTFOLIO, {
        variables: { id: address },
        skip: !address,
    });
    const mockProductDetails = {
        apy: "18%",
        stakingAsset: "USDT",
        underlyingAsset: "BTC",
        duration: "28 days",
        logoUrl: "/images/bullishSnowball.png", // Replace with actual image path
    };
    const getBtcPrice = async () => {
        try {
            const response = await fetch('https://api.coinbase.com/v2/prices/BTC-USD/spot');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            return parseFloat(data.data.amount);
        } catch (error) {
            console.error('Error fetching BTC price:', error);
            return null; // or a default value
        }
    };


    const [btcPrice, setBtcPrice] = useState(null);

    useEffect(() => {
        const fetchBtcPrice = async () => {
            const price = await getBtcPrice();
            setBtcPrice(price);
        };

        fetchBtcPrice();
    }, []);

    useEffect(() => {
        if (address) {
            refetch();
        }
    }, [address, refetch]);

    if (!address) {
        return (
            <Flex justifyContent="center" alignItems="center" height="100vh">
                <ConnectWallet theme="light" />
            </Flex>
        );
    }

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error :(</p>;

    return (
        <Box p={4}>
            <VStack spacing={4} align={"left"} paddingLeft={"20px"}>
                <Heading fontSize={"4xl"} paddingBottom={"20px"}>Portfolio</Heading>
                <Heading fontSize="2xl">Investment Summary</Heading>
                <SimpleGrid columns={{ sm: 1, md: 2, lg: 3 }} spacing={5}>
                    {data.user.portfolio.map((item) => {
                        // Part 3: BTC Price Status
                        let priceStatus, priceColor, priceIndicator;
                        if (btcPrice !== null) {
                            if (btcPrice > 48000) {
                                priceStatus = "Knock Out";
                                priceColor = "green.400";
                                priceIndicator = "increase";
                            } else if (btcPrice < 40000) {
                                priceStatus = "Knock In";
                                priceColor = "red.400";
                                priceIndicator = "decrease";
                            } else {
                                priceStatus = "At Price";
                                priceColor = useColorModeValue("gray.600", "whiteAlpha.900");
                                priceIndicator = null;
                            }
                        } else {
                            priceStatus = "Loading...";
                            priceColor = "gray.400";
                            priceIndicator = null;
                        }

                        // Part 4: Expected Profit Calculation
                        const currentTime = Math.floor(Date.now() / 1000);
                        let daysPast = (currentTime - 1702209600) / (60 * 60 * 24);
                        if (daysPast < 0) {
                            daysPast = 0;
                        }
                        const expectedProfit = parseFloat(item.holdingTargetAmount) * 44000 * (1 + 0.18 * (daysPast / 365));

                        return (
                            <Box key={item.id} p={5} shadow="md" borderWidth="1px">
                                {/* ... Parts 1 and 2 ... */}
                                {/* Part 1: Basic Information */}
                                <Flex alignItems="center">
                                    <Image
                                        src={mockProductDetails.logoUrl}
                                        alt="Product Logo"
                                        boxSize="150px"
                                        objectFit="cover"
                                        marginRight="15px"
                                    />
                                    <VStack align="start">
                                        <Text>APY: {mockProductDetails.apy}</Text>
                                        <Text>Staking Asset: {mockProductDetails.stakingAsset}</Text>
                                        <Text>Underlying Asset: {mockProductDetails.underlyingAsset}</Text>
                                        <Text>Duration: {mockProductDetails.duration}</Text>
                                    </VStack>
                                </Flex>

                                {/* Part 2: Investment Details */}
                                <Box marginTop="20px">
                                    <Text fontWeight="bold" fontSize={'medium'}>Your Investment</Text>
                                    <Text>Shares: {item.holdingTargetAmount}</Text>
                                    <Text>Invested: {(parseFloat(item.holdingTargetAmount) * 44000).toFixed(2)} USDT</Text>
                                </Box>
                                {/* Part 3: BTC Price Status */}
                                <Box marginTop="20px">

                                    <Stat borderColor={priceColor}>
                                        <StatLabel fontWeight="bold" fontSize={'medium'}>BTC Price Status</StatLabel>
                                        <StatNumber>{btcPrice ? `${btcPrice.toFixed(2)} USDT` : 'Fetching...'}</StatNumber>
                                        <StatHelpText fontSize={'medium'}>
                                            {priceIndicator && <StatArrow type={priceIndicator} />}
                                            {priceStatus}
                                        </StatHelpText>
                                    </Stat>
                                </Box>

                                {/* Part 4: Expected Profit */}
                                <Box marginTop="20px">
                                    <Text fontWeight="bold" fontSize={'medium'}>Unrealized Return</Text>
                                    <Text>{expectedProfit.toFixed(2)} USDT</Text>
                                </Box>
                                <Box marginTop="20px">

                                    <Web3Button
                                        contractAddress={SNOWBOW_PRODUCT_ADDRESS}
                                        contractAbi={SNOWBOW_PRODUCT_ABI}
                                        action={(contract) => {
                                            contract.call("claimReward")
                                        }}
                                        onSubmit={() => console.log("Transaction submitted")}
                                    >
                                        Withdraw
                                    </Web3Button>
                                </Box>

                            </Box>
                        );
                    })}
                </SimpleGrid>
            </VStack>
        </Box>
    );
};

export default PortfolioPage;
