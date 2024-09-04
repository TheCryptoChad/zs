import { useEffect, useState } from "react"
import { useVesselsStore as useVesselsStore } from "../../../stores/useVesselsStore"
import { Vessel } from "./Vessel"
import { useQuery } from "react-query"
import { API } from "../../../api/api"
import { Vector3 } from "three"
import { useEventStore } from "../../../stores/useEventStore"

export const VesselInstances = () => {
    const { addVessel, vessels } = useVesselsStore()
    const { send } = useEventStore()

    const { data: userData } = useQuery({
        queryKey: 'user',
        queryFn: API.user.getSelf
    })

    const [didSend, setDidSend] = useState(false);

    const { data: vesselsData } = useQuery({
        enabled: !!userData?.address,
        queryKey: 'vessels',
        queryFn: API.vessel.getAll,
        onSuccess: (data) => {
            const validVessel = data.find(vessel => (vessel.x ?? 0) > 0 && (vessel.y ?? 0) > 0);

            if (validVessel && !didSend) {
                send({
                    type: "GOTO",
                    payload: validVessel,
                    options: {
                        instant: true
                    }
                });
                setDidSend(true);
            }
        }
    })

    useEffect(() => {
        if (vesselsData && vesselsData.length > 0) {
            vesselsData.forEach((vessel: API.VesselResponse) => {
                const newVessel: Vessel = {
                    id: Number(vessel.id),
                    name: vessel.name,
                    position: new Vector3(Number(vessel.x), 0, Number(vessel.y)),
                    isLocked: false,
                    miningEndTime: vessel.miningEndTime,
                    range: Number(vessel.range),
                    speed: Number(vessel.speed),
                    radar: Number(vessel.radar),
                }
                addVessel(newVessel)
            });
        }
    }, [vesselsData, addVessel])

    return Array.from(vessels).map(([key, vessel]) => (
        (
            vessel.position.x > 0 &&
            vessel.position.z > 0
        ) && <Vessel key={key} vessel={vessel} />
    ))
}