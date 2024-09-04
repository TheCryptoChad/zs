import { Heading, VStack, Button, Image } from "@chakra-ui/react"
import { ReactNode } from "react"
import { isMobile } from "react-device-detect"
import Arrow from "../../../../assets/icons/arrow.png"

export const WorkbenchResourcePane = ({ children }: { children: ReactNode }) => {
    return (
        <VStack
            width={"auto"}
            flexShrink={0}
            h={"full"}
            gap={0}
            bg={"samaBlackFade"}
            p={4}
            rounded={"md"}
            position="relative"
        >
            <Heading
                textTransform={"uppercase"}
                fontFamily={"Orbitron"}
                textColor={"samaWhite"}
                letterSpacing={2}
                mb={4}
            >
                Workbench
            </Heading>
            <Button
                w={isMobile ? 9 : 10}
                h={isMobile ? 9 : 10}
                p={isMobile ? 1.5 : 2}
                bg="#25434F"
                color="samaWhite"
                fontFamily={"Orbitron"}
                fontSize={"small"}
                letterSpacing={1.5}
                rounded={"sm"}
                borderColor={"samaTeal.500"}
                borderWidth={0.5}
                onClick={() => window.location.href = "/game"}
                cursor={"pointer"}
                _hover={{
                    background: "#0EEBA8",
                    color: "#191919",
                    transform: "translateY(-3px)",
                    boxShadow: "0px 3px 10px #0EEBA8",
                }}
                transition="0.3s"
                textTransform={"uppercase"}
                position="absolute"
                top="2%"
                left="2%"
            >
                <Image src={Arrow} />
            </Button>
            {children}
        </VStack>
    )
}