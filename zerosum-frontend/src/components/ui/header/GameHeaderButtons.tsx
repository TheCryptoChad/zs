import { SettingsIcon } from "@chakra-ui/icons";
import { Button, Flex, Image, Tooltip } from "@chakra-ui/react";
import { isMobile } from "react-device-detect";
import TrophyIcon from "../../../assets/icons/trophy_icon.svg";
import SoundOn from "../../../assets/icons/sound_on.png";
import SoundOff from "../../../assets/icons/sound_off.png";
import Workbench from "../../../assets/icons/workbench_icon.png";
import Referral from "../../../assets/icons/referral.png";
import { useSoundStore } from "../../../stores/useSoundStore";

export const GameHeaderButtons = ({ handleBackdropClick }: { handleBackdropClick: () => void }) => {
	const { sound, toggleSound } = useSoundStore();

	const goToLeaderboard = () => {
		const url = `/leaderboard`;
		window.location.href = url;
	};

	const goToWorkbench = () => {
		const url = `/workbench`;
		window.location.href = url;
	};

    const goToReferrals = () => {
		const url = `/referrals`;
		window.location.href = url;
	};

	return (
		<Flex
			bg={"samaBlackFade"}
			px={isMobile ? 2 : 4}
			py={isMobile ? 2 : 3}
			rounded={"sm"}
			pointerEvents={"auto"}
			alignSelf={"start"}
			direction={isMobile ? "column-reverse" : "row"}
			gap={2}
		>
			<Tooltip label="Toggle Sound">
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
					onClick={toggleSound}
					cursor={"pointer"}
					_hover={{
						background: "#0EEBA8",
						color: "#191919",
						transform: "translateY(-3px)",
						boxShadow: "0px 3px 10px #0EEBA8",
					}}
					transition="0.3s"
					textTransform={"uppercase"}
				>
					<Image src={sound ? SoundOn : SoundOff} />
				</Button>
			</Tooltip>
            <Tooltip label="Referrals">
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
					onClick={goToReferrals}
					cursor={"pointer"}
					_hover={{
						background: "#0EEBA8",
						color: "#191919",
						transform: "translateY(-3px)",
						boxShadow: "0px 3px 10px #0EEBA8",
					}}
					transition="0.3s"
					textTransform={"uppercase"}
				>
					<Image src={Referral} />
				</Button>
			</Tooltip>
			<Tooltip label="Workbench">
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
					onClick={goToWorkbench}
					cursor={"pointer"}
					_hover={{
						background: "#0EEBA8",
						color: "#191919",
						transform: "translateY(-3px)",
						boxShadow: "0px 3px 10px #0EEBA8",
					}}
					transition="0.3s"
					textTransform={"uppercase"}
				>
					<Image src={Workbench} />
				</Button>
			</Tooltip>
			<Tooltip label="Leaderboard">
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
					onClick={goToLeaderboard}
					cursor={"pointer"}
					_hover={{
						background: "#0EEBA8",
						color: "#191919",
						transform: "translateY(-3px)",
						boxShadow: "0px 3px 10px #0EEBA8",
					}}
					transition="0.3s"
					textTransform={"uppercase"}
				>
					<Image src={TrophyIcon} />
				</Button>
			</Tooltip>
			<Tooltip label="Settings Menu">
				<SettingsIcon
					w={"auto"}
					h={isMobile ? 9 : 10}
					p={isMobile ? 2 : 2}
					bg="#25434F"
					color="samaWhite"
					fontFamily={"Orbitron"}
					fontSize={"small"}
					letterSpacing={1.5}
					rounded={"sm"}
					borderColor={"samaTeal.500"}
					borderWidth={0.5}
					onClick={handleBackdropClick}
					cursor={"pointer"}
					_hover={{
						background: "#0EEBA8",
						color: "#191919",
						transform: "translateY(-3px)",
						boxShadow: "0px 3px 10px #0EEBA8",
					}}
					transition="0.3s"
					textTransform={"uppercase"}
				/>
			</Tooltip>
		</Flex>
	);
};
