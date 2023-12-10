import React from 'react';
import { Box, Flex, Accordion, AccordionItem, AccordionButton, AccordionPanel, AccordionIcon, FormLabel, Input, Button, Text, Image } from '@chakra-ui/react';
import {
    Table,
    Thead,
    Tbody,
    Tfoot,
    Tr,
    Th,
    Td,
    TableCaption,
    TableContainer,
} from '@chakra-ui/react'
import { Card, CardHeader, CardBody, CardFooter } from '@chakra-ui/react'
import { Heading } from '@chakra-ui/react';
import { Progress, VStack } from '@chakra-ui/react';
import {
    Stat,
    StatLabel,
    StatNumber,
    StatHelpText,
    StatArrow,
    StatGroup,
} from '@chakra-ui/react'
import { Tabs, TabList, TabPanels, Tab, TabPanel } from '@chakra-ui/react'

function App() {
    return (
        <Box>
            {/* Upper Part */}
            <Box bg="rgb(24, 19, 33)" h="33vh" w="100%" >
                <Flex align="center" justify="center">
                    {/* Left Section */}
                    <Flex direction="column" width="70%" height="100%" justify={"c"} p={4} paddingLeft={"300px"}>
                        {/* Top 1/3 */}
                        <Box flex={1} p={4} color="white">
                            <Image src={"https://cryptologos.cc/logos/polygon-matic-logo.svg?v=029"} alt="Polygon Logo" boxSize="20px" />
                        </Box>

                        {/* Middle 1/3 */}
                        <Box flex={1} p={4} color="white">
                            <Heading color={"white"}>Bearish Snowball</Heading>
                        </Box>

                        {/* Bottom 1/3 with Stat */}
                        <Box flex={1} p={4} color="white" justifyContent={"center"}>
                            <StatGroup>
                                <Stat color={"rgb(214,226,74)"} fontWeight={"bold"} >
                                    <StatLabel>FIXED APY</StatLabel>
                                    <StatNumber>18%</StatNumber>

                                </Stat>
                                <Stat>
                                    <StatLabel>STAKING ASSET</StatLabel>
                                    <StatNumber>wBTC</StatNumber>

                                </Stat>
                                <Stat>
                                    <StatLabel>UNDERLYING ASSET</StatLabel>
                                    <StatNumber>BTC</StatNumber>

                                </Stat>
                                <Stat>
                                    <StatLabel>DURATION</StatLabel>
                                    <StatNumber>28 DAYS</StatNumber>

                                </Stat>
                                <Stat>
                                    <StatLabel>PRODUCT TVL</StatLabel>
                                    <StatNumber>$186,964,44</StatNumber>

                                </Stat>
                                {/* Additional Stats Here */}
                            </StatGroup>
                        </Box>
                    </Flex>

                    {/* Right Section with Image */}
                    <Box width="50%" height="100%">
                        <Image src="/images/bear-bg.png" alt="Descriptive Alt Text" objectFit="cover" boxSize="270px" />
                    </Box>
                </Flex>
            </Box>

            {/* Lower Part */}
            <Flex h="67vh" w="100%" justify="center">
                {/* Container for Lower Two Parts */}
                <Box width="70%" display="flex">
                    {/* Left Part with Accordion */}
                    <Box flex="2" p="4">
                        <Accordion allowMultiple>
                            {/* Repeat AccordionItem for each item you need */}
                            <AccordionItem>
                                <h2>
                                    <AccordionButton _expanded={{ bg: '#000000', color: 'white' }}>
                                        <Box flex="1" textAlign="left" fontWeight={"bold"}>
                                            Investment Summary
                                        </Box>
                                        <AccordionIcon />

                                    </AccordionButton>
                                </h2>
                                <AccordionPanel pb={4}>
                                    <Heading fontSize={"large"}>What is Snowball?</Heading>
                                    Snowball is a unique product that allows you to strategize, manage risk, and make lucrative returns in different market conditions<br /><br />
                                    <Heading fontSize={"large"}>Incredible returns</Heading>
                                    Enjoy up to 20% est. APRs on leading crypto such as BTC, ETH or USDT<br /><br />
                                    <Heading fontSize={"large"}>Partial downside protection</Heading>
                                    Markets need to move drastically against you before you experience any losses<br />
                                </AccordionPanel>
                            </AccordionItem>
                            {/* Order Detail Example */}
                            <AccordionItem>
                                <h2>
                                    <AccordionButton _expanded={{ bg: '#000000', color: 'white' }}>
                                        <Box flex="1" textAlign="left" fontWeight={"bold"}>
                                            Order Detail Example
                                        </Box>
                                        <AccordionIcon />

                                    </AccordionButton>
                                </h2>
                                <AccordionPanel pb={4}>
                                    <Card>
                                        <CardBody>
                                            <TableContainer>
                                                <Table variant='simple'>
                                                    <TableCaption>Order details example</TableCaption>

                                                    <Tbody>
                                                        <Tr>
                                                            <Td>Product</Td>
                                                            <Td>Bearish on BTC</Td>
                                                        </Tr>
                                                        <Tr>
                                                            <Td>Principal</Td>
                                                            <Td>5 BTC</Td>
                                                        </Tr>
                                                        <Tr>
                                                            <Td>Term</Td>
                                                            <Td>28 days</Td>
                                                        </Tr>
                                                        <Tr>
                                                            <Td>APR
                                                            </Td>
                                                            <Td>19.00%</Td>
                                                        </Tr>
                                                        <Tr>
                                                            <Td>Strike price</Td>
                                                            <Td>$26,000</Td>
                                                        </Tr>
                                                        <Tr>
                                                            <Td>Knock-out price</Td>
                                                            <Td>$25,700</Td>
                                                        </Tr>
                                                        <Tr>
                                                            <Td>Knock-in price</Td>
                                                            <Td>$31,200</Td>
                                                        </Tr>
                                                    </Tbody>

                                                </Table>
                                            </TableContainer>
                                        </CardBody>
                                    </Card>
                                    <Text color={'gray'}>The Knock-out price is observed every Friday, 16:00:00.</Text>
                                    <Text color={'gray'}>The Knock-in price is observed Observed daily, 16:00:00.</Text>
                                </AccordionPanel>
                            </AccordionItem>
                            {/* Scenario 1/4 - Earn more BTC when a knock-out (KO) event occurs */}
                            <AccordionItem>
                                <h2>
                                    <AccordionButton _expanded={{ bg: '#000000', color: 'white' }}>
                                        <Box flex="1" textAlign="left" fontWeight={"bold"}>
                                            Scenario 1/4 - Earn more BTC when a knock-out (KO) event occurs
                                        </Box>
                                        <AccordionIcon />

                                    </AccordionButton>
                                </h2>
                                <AccordionPanel pb={4}>
                                    <Card>
                                        <CardBody>
                                            <Image src={"/images/bear1.png"} />

                                            <Text fontWeight={"bold"}>you will receive your earnings on the KO date


                                            </Text>
                                            <Text>Earnings = Principal x (1 + APR x Term / 365)

                                            </Text>
                                            <Text>Earnings = 5 x (1 + 0.19 x 21 / 365)

                                            </Text>
                                            <Text fontWeight={"bold"}>= 5.05 BTC

                                            </Text>

                                        </CardBody>
                                    </Card>
                                </AccordionPanel>
                            </AccordionItem>
                            {/* Scenario 2/4 - Earn more BTC when a knock-out (KO) event occurs */}
                            <AccordionItem>
                                <h2>
                                    <AccordionButton _expanded={{ bg: '#000000', color: 'white' }}>
                                        <Box flex="1" textAlign="left" fontWeight={"bold"}>
                                            Scenario 2/4 – Earn more USDT when neither a knock-out (KO) nor a knock-in (KI) event occurs
                                        </Box>
                                        <AccordionIcon />

                                    </AccordionButton>
                                </h2>
                                <AccordionPanel pb={4}>
                                    <Card>
                                        <CardBody>
                                            <Image src={"/images/bear2.png"} />

                                            <Text fontWeight={"bold"}>you will receive your earnings on the expiration date:




                                            </Text>
                                            <Text>Earnings = Principal x (1 + APR x Term / 365)



                                            </Text>
                                            <Text>Earnings = 5 x (1 + 0.19 x 28 / 365)



                                            </Text>
                                            <Text fontWeight={"bold"}>= 5.07 BTC

                                            </Text>

                                        </CardBody>
                                    </Card>
                                </AccordionPanel>
                            </AccordionItem>
                            {/* Scenario 3/4 - Earn more BTC when a knock-out (KO) event occurs */}
                            <AccordionItem>
                                <h2>
                                    <AccordionButton _expanded={{ bg: '#000000', color: 'white' }}>
                                        <Box flex="1" textAlign="left" fontWeight={"bold"}>
                                            Scenario 3/4 – No gains or losses if a knock-in (KI) event occurs and the price expires between the strike and knock-out (KO) prices
                                        </Box>
                                        <AccordionIcon />

                                    </AccordionButton>
                                </h2>
                                <AccordionPanel pb={4}>
                                    <Card>
                                        <CardBody>
                                            <Image src={"/images/bear3.png"} />

                                            <Text fontWeight={"bold"}>you will receive your principal on the expiration date:







                                            </Text>
                                            <Text>Earnings = Principal
                                            </Text>
                                            <Text fontWeight={"bold"}>= 5 BTC

                                            </Text>

                                        </CardBody>
                                    </Card>
                                </AccordionPanel>
                            </AccordionItem>
                            {/* Scenario 4/4 - Earn more BTC when a knock-out (KO) event occurs */}
                            <AccordionItem>
                                <h2>
                                    <AccordionButton _expanded={{ bg: '#000000', color: 'white' }}>
                                        <Box flex="1" textAlign="left" fontWeight={"bold"}>
                                            Scenario 4/4 – Receive BTC when a knock-in (KI) event occurs and the price expires at or below the strike price
                                        </Box>
                                        <AccordionIcon />

                                    </AccordionButton>
                                </h2>
                                <AccordionPanel pb={4}>
                                    <Card>
                                        <CardBody>
                                            <Image src={"/images/bear4.png"} />

                                            <Text fontWeight={"bold"}>you will receive USDT on the expiration date:






                                            </Text>
                                            <Text>Earnings = Principal x Strike price





                                            </Text>
                                            <Text>Earnings = 5 x 26,000





                                            </Text>
                                            <Text fontWeight={"bold"}>= 130000 USDT



                                            </Text>

                                        </CardBody>
                                    </Card>
                                </AccordionPanel>
                            </AccordionItem>
                        </Accordion>
                    </Box>

                    {/* Space between the two parts */}
                    <Box width="10%" />

                    {/* Right Part with Form */}
                    <Box flex="1" p="4" bg="white">
                        <Card>
                            <CardBody>
                                <Tabs isFitted variant='enclosed'>
                                    <TabList mb='1em'>
                                        <Tab fontWeight={"bold"}>DEPOSIT</Tab>

                                        <Tab fontWeight={"bold"}>WITHDRAW</Tab>
                                    </TabList>
                                    <TabPanels>
                                        <TabPanel>
                                            {/* <p>one!</p> */}
                                        </TabPanel>
                                        <TabPanel>
                                            {/* <p>two!</p> */}
                                        </TabPanel>
                                    </TabPanels>
                                </Tabs>
                            </CardBody>
                        </Card>
                    </Box>
                </Box>
            </Flex>
        </Box>
    );
}

export default App;
