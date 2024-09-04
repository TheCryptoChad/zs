import { Box, Image, Spinner, Text, Tooltip, VStack } from "@chakra-ui/react"
import { Suspense } from "react"
import { getFormattedAmount } from "../workbenchUtils/functions/functions"

type ResourceButtonProps = {
    id: number
    address: string
    src: string
    name: string
    description: string
    onClick: () => void
    selection: Workbench.Craftable | null
    tokenBalances: SquidBalancesResponse | undefined
}

export const WorkbenchResourceItem = ({ id, address, src, name, description, onClick, selection, tokenBalances }: ResourceButtonProps) => {

    const getSelectionFilter = () => {
        const isNameWithId = selection?.id === id && selection.name === name
        if (isNameWithId || !selection) {
            if(amount === 0) return "saturate(10%)"
            return {}
        } else {
            if(amount === 0) return "brightness(50%) saturate(10%)"
            return "brightness(50%) saturate(80%)"
        }
    }

    const getHoverFilter = () => {
        const isNameWithId = selection?.id === id && selection.name === name
        if (!isNameWithId) {
            if(amount === 0) return "brightness(75%) saturate(10%)"
            return "brightness(75%) saturate(80%)"
        }
    }

    const token: Erc20Contract | Erc1155Token | undefined =
		id === 0
            ? tokenBalances?.data.erc20Contracts.find((contract: Erc20Contract) => contract.address === address.toLowerCase())
            : (tokenBalances?.data.erc1155Contracts.find((contract: Erc1155Contract) => contract.address === address.toLowerCase()))?.tokens.find((token: Erc1155Token) => token.tokenId === id);
    const amount: number = !token || !token.owners.length ? 0 : (token as Erc20Contract).decimals ? Number((token as Erc20Contract).owners[0]?.balance || 0) / 10 ** Number((token as Erc20Contract).decimals || 1) : Number((token as Erc1155Token).owners[0]?.balance || 0);

    return (
        <Tooltip
            label={
                <VStack>
                    <Text letterSpacing={1.5} textTransform={"uppercase"} fontSize={"sm"} fontFamily={"Orbitron"}>{name}</Text>
                    <Text fontFamily={"Raleway"}>{description}</Text>
                    <Text fontFamily={"Raleway"} textColor={"samaTeal.500"}>You Own: {getFormattedAmount(amount)}</Text>
                </VStack>
            }
            placement="right"
            className="gildedBorderTooltip"
            p={4}
        >
            <Box
                className="gildedBorder"
                borderWidth={0.5}
                w={20}
                h={20}
                display="flex"
                alignItems="center"
                justifyContent="center"
                transition="filter 0.1s ease-in-out"
                boxShadow="inset 0px 0px 10px rgba(0, 0, 0, 0.5)"
                _hover={{
                    filter: getHoverFilter()
                }}
                filter={getSelectionFilter()}
            >
                <Suspense fallback={
                    <Spinner color="samaTeal.500" />
                }>
                    <Image
                        src={src}
                        className="gildedBorder"
                        w={"100%"}
                        h={"100%"}
                        objectFit={"contain"}
                        cursor={"pointer"}
                        onClick={onClick}
                    />
                </Suspense>
            </Box>
        </Tooltip>
    )
}
