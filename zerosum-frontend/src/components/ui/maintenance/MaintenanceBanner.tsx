import { Flex } from "@chakra-ui/react";

export const MaintenaceBanner = () => {
 return (
        <Flex
            bg="#E53E3E"
            position="absolute"
            top="100%"
            left="0%"
            width="100vw"
            height="5vh"
            color="samaWhite"
            alignItems="center"
            justify="center"
            fontSize="1.5em"
            transform="translateY(-100%)"
            zIndex={100}
        >
            Zero Sum is currently under maintenance. Be careful as the site may not work as intended.
        </Flex>
    );
};