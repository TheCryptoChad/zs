import { HStack, Image, Tooltip } from "@chakra-ui/react";
import { isMobile } from "react-device-detect";
import { useQuery } from "react-query";
import { API } from "../../../api/api";

export const GameHeaderUpgrades = () => {
	const { data: userData } = useQuery({
		queryKey: "user",
		queryFn: API.user.getSelf,
	});

	const { data: vesselData } = useQuery({
		enabled: !!userData?.address,
		queryKey: "vessels",
		queryFn: API.vessel.getAll,
	});

	useQuery({
		queryFn: () => {
			if(userData?.referredBy) return;
			const pendingReferral: string | null = localStorage.getItem("pendingReferral");
			if (pendingReferral) API.user.addPendingReferral(pendingReferral);
		},
		enabled: !!userData
	})

	const getLevel = (upgrade: string): string => {
		if (vesselData) {
			switch (upgrade) {
				case "speed":
					if (Number(vesselData[0]?.speed) === 0) {
						return "";
					} else {
						return `${vesselData[0]?.speed}`;
					}
				case "range":
					if (Number(vesselData[0]?.range) === 1) {
						return "";
					} else {
						return `${Number(vesselData[0]?.range) - 1}`;
					}
				case "radar":
					if (Number(vesselData[0]?.radar) === 0) {
						return "";
					} else if (Number(vesselData[0]?.radar) === 6) {
						return "5";
					} else {
						return `${vesselData[0]?.radar}`;
					}
			}
		}
		return "";
	};

	return (
		<HStack
			bg={"samaBlackFade"}
			p={isMobile ? 0 : 2}
			rounded={"sm"}
			pointerEvents={"auto"}
			gap={0}
			alignItems={"start"}
            w={isMobile ? "100%" : "auto"}
            display="flex"
            justifyContent="space-around"
		>
			<Tooltip
				my={0.5}
				bg={"samaBlackFade"}
				color={"samaWhite"}
				rounded={"sm"}
				fontFamily={"Raleway"}
				textTransform={"capitalize"}
				label={`Speed Upgrade Lv. ${getLevel("speed") || "0"}`}
			>
                <HStack gap={1} p={1}>
				<Image
                    _hover={{ cursor: "pointer" }}
					borderRadius="50%"
					src={`./workbench/speed/speed${getLevel("speed")}.png`}
					h={10}
				/>
                </HStack>
			</Tooltip>
			<Tooltip
				my={0.5}
				bg={"samaBlackFade"}
				color={"samaWhite"}
				rounded={"sm"}
				fontFamily={"Raleway"}
				textTransform={"capitalize"}
				label={`Range Upgrade Lv. ${getLevel("range") || "0"}`}
			>
                <HStack gap={1} p={1}>
				<Image
					_hover={{ cursor: "pointer" }}
					borderRadius="50%"
					src={`./workbench/range/range${getLevel("range")}.png`}
					h={10}
				/>
                </HStack>
			</Tooltip>
			<Tooltip
				my={0.5}
				bg={"samaBlackFade"}
				color={"samaWhite"}
				rounded={"sm"}
				fontFamily={"Raleway"}
				textTransform={"capitalize"}
				label={`Radar Upgrade Lv. ${getLevel("radar") || "0"}`}
			>
                <HStack gap={1} p={1}>
				<Image
					_hover={{ cursor: "pointer" }}
					borderRadius="50%"
					src={`./workbench/radar/radar${getLevel("radar")}.png`}
					h={10}
				/>
                </HStack>
			</Tooltip>
		</HStack>
	);
};
