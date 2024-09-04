import { Button, Spinner, useToast } from "@chakra-ui/react"
import { useMutation } from "react-query"
import { queryClient } from "../../../../main"
import { API } from "../../../../api/api"
import { useEventStore } from "../../../../stores/useEventStore"

export const MiningMenuFinishButton = ({ vessel }: { vessel: Vessel }) => {
    const { clear } = useEventStore()

    const successToast = useToast();
    const errorToast = useToast();

    const { mutate, isLoading } = useMutation((newData: { vesselId: number }) => API.vessel.finishMining(newData.vesselId), {
        onSuccess: (data) => {
            // Invalidate and refetch
            queryClient.invalidateQueries('vessels')
            queryClient.invalidateQueries('resources')
            queryClient.invalidateQueries('exhausted-tiles')

            successToast({
                title: "Mining Operation",
                description: `Mining finished successfully.\nYou mined ${data.awardedAmount} ${data.resourceType}!`,
                status: "success",
                duration: 5000,
                isClosable: true,
            })

            clear()
        },
        onError: () => {
            errorToast({
                title: "Mining Operation",
                description: "Failed to finish mining.",
                status: "error",
                duration: 5000,
                isClosable: true,
            })
        }
    })
    return (
        <Button
            boxShadow="0px 4px 10px rgba(0, 0, 0, 0.5)"
            letterSpacing={1.5}
            fontFamily={"Orbitron"}
            color={"samaWhite"}
            bg={"samaSpace01"}
            isDisabled={isLoading}
            _hover={{
                background: "#samaSpace02",
                transform: "translateY(-3px)",
                boxShadow: "0px 3px 10px #0EEBA8"
            }}
            className="gildedBorder"
            onClick={() => vessel && mutate({ vesselId: vessel.id })
            }
        >
            {isLoading ? <Spinner color="samaTeal.500" /> : "Finish Mining"}
        </Button>
    )
}