import { Circle, Image, Flex } from "@chakra-ui/react"
import { addTokenToWallet } from "../header/GameHeaderClaim/AddTokenToWallet";

export const SidebarItemIcon = ({id}: any) => {
    return (
        <Circle
            size={"68px"}
            rounded={"full"}
            bgGradient={"linear(to-t, samaBlue.500, samaTeal.500)"}
            _hover={{ boxShadow: "0px 0px 5px #FFFFFF", cursor: "pointer" }}
            onClick={() => addTokenToWallet(3_441_005, "ship", id)}
        >
            <Flex justify="center" align="center" h="full" w="full">
                <Image
                    src="./ship.png"
                    w={"64px"}
                    h={"64px"}
                    rounded={"full"}
                    mb={"1px"}
                />
            </Flex>
        </Circle>
    );
};
