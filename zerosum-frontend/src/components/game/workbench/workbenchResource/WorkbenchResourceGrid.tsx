import { Divider, Grid, Text } from "@chakra-ui/react"
import { ReactNode } from "react"

type GridProps = {
    label: string
    children: ReactNode
}

export const WorkbenchResourceGrid = ({ label = "Schematics", children }: GridProps) => {
    return (
        <>
            <Text
                textTransform={"uppercase"}
                fontFamily={"Orbitron"}
                letterSpacing={1.5}
                fontSize={"sm"}
                alignSelf={"start"}
                textColor={"samaTeal.500"}
            >
                {label}
            </Text>
            <Divider mb={3} />
            <Grid
                gap={2}
                mb={8}
                templateColumns={"repeat(5, 1fr)"}
            >
                {children}
            </Grid>
        </>
    )
}