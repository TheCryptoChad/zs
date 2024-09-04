import { Button, Spinner, useToast } from "@chakra-ui/react"
import { useMutation } from "react-query"
import { queryClient } from "../../../../main"
import { API } from "../../../../api/api"
import { useEventStore } from "../../../../stores/useEventStore"
import { useVesselsStore } from "../../../../stores/useVesselsStore"
import { useSoundStore } from "../../../../stores/useSoundStore"
import { Howl } from "howler";
import MiningCompleteSound from "../../../../assets/sounds/mining_complete.wav"

export const MiningMenuStartButton = ({ vessel }: { vessel: Vessel }) => {
    const { sound } = useSoundStore();

    const { clear } = useEventStore()
    const { clearSelectedVessel } = useVesselsStore()

    const successToast = useToast();
    const errorToast = useToast();

    const playSound = () => {
        if (sound) {
            const audio = new Howl({
                src: [MiningCompleteSound],
                volume: 0.9
            });

            audio.play()
        }
    }

    const { mutate, isLoading } = useMutation((newData: { vesselId: number }) => API.vessel.startMining(newData.vesselId), {
        onSuccess: () => {
            // Invalidate and refetch
            queryClient.invalidateQueries('vessels')
            successToast({
                title: "Mining Operation",
                description: "Mining started successfully.",
                status: "success",
                duration: 5000,
                isClosable: true,
            })
            clear()
            clearSelectedVessel()
            setTimeout(playSound, Number(vessel?.speed || 0) === 0 ? 60_000 : Number(vessel?.speed || 0) === 1 ? 57_000 : Number(vessel?.speed || 0) === 2 ? 54_000 :Number(vessel?.speed || 0) === 3 ? 51_000 :Number(vessel?.speed || 0) === 4 ? 48_000 : 45_000);
        },
        onError: () => {
            errorToast({
                title: "Mining Operation",
                description: "Failed to start mining.",
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
            {isLoading ? <Spinner color="samaTeal.500" /> : "Start Mining"}
        </Button>
    )
}