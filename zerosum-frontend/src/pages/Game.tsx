import { Suspense, useEffect } from "react";
import { Box } from "@chakra-ui/react";
import { GameCanvas } from "../components/game/GameCanvas";
import { UIOverlay } from "../components/ui/UIOverlay";
import { useConnect } from "wagmi";
import { InjectedConnector } from "wagmi/connectors/injected";
import { MaintenaceBanner } from "../components/ui/maintenance/MaintenanceBanner";

const Game = (): JSX.Element => {
	const { connect } = useConnect({
		connector: new InjectedConnector()
	})

	useEffect(() => {
		connect();
	}, [])

	const fallbackBox: JSX.Element = (
		<Box
			position="absolute"
			w="100vw"
			h="100vh"
			zIndex={1000}
			p={4}
			backdropFilter="auto"
			backdropBlur="md"
			display="flex"
			alignItems="center"
			justifyContent="center"
		/>
	);

	return (
		<Suspense fallback={fallbackBox}>
			{import.meta.env.VITE_MAINTENANCE_MODE === "true" && <MaintenaceBanner />}
			<UIOverlay />
			<GameCanvas />
		</Suspense>
	);
};

export default Game;
