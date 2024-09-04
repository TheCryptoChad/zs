import { useState, useEffect } from 'react';
import { Heading, Text, Input, Button, useToast, VStack, Spinner, Flex } from '@chakra-ui/react';
import { useMutation } from 'react-query';
import { API } from "../../../api/api"
import { queryClient } from '../../../main';
import { isMobile } from 'react-device-detect';

export const SidebarDeployBox = ({ vesselId, handleDeployClick }: { vesselId: number, handleDeployClick: () => void }) => {
    const [xCoordinate, setXCoordinate] = useState('');
    const [yCoordinate, setYCoordinate] = useState('');
    const [isValid, setIsValid] = useState(false);

    const toast = useToast({ duration: 5 });

    const { mutate, isError, error } = useMutation((newData: { vesselId: number, x: number, y: number }) => API.vessel.deploy(newData.vesselId, newData.x, newData.y), {
        onSuccess: () => {
            // Invalidate and refetch
            queryClient.invalidateQueries('vessels')
            handleDeployClick(); // Close the SidebarDeployBox
            toast({
                title: `Vessel ${vesselId} deployed successfully!`,
                status: "success",
                duration: 5000,
                isClosable: true,
                variant: "success",
            });
        },
    })

    useEffect(() => {
        const xIsValid = Number(xCoordinate) >= 1 && Number(xCoordinate) <= 100;
        const yIsValid = Number(yCoordinate) >= 1 && Number(yCoordinate) <= 100;
        setIsValid(xIsValid && yIsValid);
    }, [xCoordinate, yCoordinate]);

    return (
        <VStack
            className='gildedBorder'
            zIndex={101}
            color={"samaWhite"}
            bg="samaBlack"
            p={5}
            borderWidth={2}
            boxShadow="lg"
            h={isMobile ? "90%" : "auto"}
            w={isMobile ? "90%" : "auto"}
        >
            <Heading fontFamily={"Orbitron"} color={"samaTeal.500"} letterSpacing={2} textTransform={"uppercase"} mb={4}>Deploy vessel</Heading>
            <Text fontFamily={"Raleway"} mb={4}>Please input the X and Y coordinates of your vessel to proceed.<br />Valid values are from 1 to 100 inclusive.</Text>
            <Text color="red" minHeight="1.5em">{isError ? (error as Error)?.message : "\u00A0"}</Text>
            <Flex direction={isMobile ? 'column' : 'row'} gap={4} mb={4}>
                <Input
                    type="number"
                    min={1}
                    max={100}
                    width={60}
                    placeholder="Enter X Coordinate..."
                    value={xCoordinate}
                    onChange={(e) => setXCoordinate(e.target.value)}
                />
                <Input
                    type="number"
                    min={1}
                    max={100}
                    width={60}
                    placeholder="Enter Y Coordinate..."
                    value={yCoordinate}
                    onChange={(e) => setYCoordinate(e.target.value)}
                />
            </Flex>
            <Button isDisabled={!isValid} spinner={<Spinner color="samaTeal.500" />} onClick={() => mutate({
                vesselId: vesselId,
                x: Number(xCoordinate),
                y: Number(yCoordinate)
            })}>
                Submit
            </Button>
        </VStack>
    );
};
