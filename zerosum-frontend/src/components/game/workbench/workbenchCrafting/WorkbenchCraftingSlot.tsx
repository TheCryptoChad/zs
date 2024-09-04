import { Box, Image, Text } from "@chakra-ui/react";
import { getFormattedAmount, getRequiredAmount } from "../workbenchUtils/functions/functions";

export const WorkbenchCraftingSlot = ({ currentAmount = 0, requiredItem, selectedItem }: { currentAmount: number, requiredItem: Workbench.Craftable, selectedItem: Workbench.Craftable }) => {
    return (
        <Box position={"relative"}>
            <Image
                src={requiredItem.src}
                objectFit="cover"
                className="gildedBorder"
                w={20}
                h={20}
                filter={
                    currentAmount < getRequiredAmount(selectedItem.name, requiredItem)
                        ? "grayscale(100%)"
                        : {}
                }
            />
            <Text
                position="absolute"
                bottom={0}
                left={0}
                right={0}
                bgColor="rgba(0,0,0,0.5)"
                color="samaWhite"
                textAlign="center"
                fontSize={"xx-small"}
                fontFamily={"Orbitron"}
                letterSpacing={1.5}
            >
                {getFormattedAmount(currentAmount)}/{getFormattedAmount(getRequiredAmount(selectedItem.name, requiredItem))}
            </Text>
        </Box>
    )
}
