import { Flex, Text, Image, VStack } from "@chakra-ui/react";
import { isMobile } from "react-device-detect";

type MiningResource = {
    src: string
    name: string
    percentage: number
}

const getColor = (value: number) => {
    if (value <= 33) {
        return "red";
    } else if (value > 33 && value <= 66) {
        return "yellow";
    } else if (value > 66) {
        return "green";
    } else {
        return "samaWhite"
    }
};

export const MiningMenuResources = ({ probabilities }: { probabilities: Entity.Resources }) => {
    const resources = [
        { src: "resources/astralite.png", name: "Astralite", percentage: probabilities.astralite },
        { src: "resources/samarium.png", name: "Samarium", percentage: probabilities.samarium },
        { src: "resources/calamarite.png", name: "Calamarite", percentage: probabilities.calamarite }
    ];

    return (
        <Flex
            direction={isMobile ? "column" : "row"}
            justifyContent="space-around"
            gap={isMobile ? 0 : 6}
            align="center"
            height={isMobile ? "auto" : "100%"}
            maxWidth="80%"
            mx="auto"
            my="6"
        >
            {resources.map((resource) => {
                const color = getColor(resource.percentage);

                return (
                    isMobile
                        ? <MiningResourceMobile key={resource.name} resource={resource} color={color} />
                        : <MiningResource key={resource.name} resource={resource} color={color} />
                );
            })}
        </Flex>
    );
};

const MiningResource = ({ resource, color }: { resource: MiningResource, color: string }) => {
    return (
        <Flex key={resource.name} direction={"column"} alignItems="center" justifyContent="center" height="full">
            <Text fontSize="xl" fontFamily={"Orbitron"} textTransform={"uppercase"} bg="#191919AA" px={2} rounded={"sm"}>{resource.name}</Text>
            <Image my={2} height="50%" objectFit="contain" src={resource.src} alt={resource.name} />
            <Text fontSize="xl" fontFamily={"Orbitron"} textTransform={"uppercase"} bg="#191919AA" px={2} rounded={"sm"} color={color}>
                {resource.percentage}%
            </Text>
        </Flex>
    )
}

const MiningResourceMobile = ({ resource, color }: { resource: MiningResource, color: string }) => {
    return (
        <Flex key={resource.name} w={"100%"} direction={"row"} alignItems="center" justifyContent="space-between" height="100%">
            <VStack mr={4} fontSize="l" fontFamily={"Orbitron"} textTransform={"uppercase"}>
                <Text textAlign={"center"} w={"140px"} bg="#191919AA" px={2} rounded={"sm"}>{resource.name}</Text>
                <Text textAlign={"center"} w={"100px"} bg="#191919AA" px={2} rounded={"sm"} color={color}>
                    {resource.percentage}%
                </Text>
            </VStack>
            <Image my={2} height="75px" objectFit="contain" src={resource.src} alt={resource.name} />
        </Flex>
    )
}