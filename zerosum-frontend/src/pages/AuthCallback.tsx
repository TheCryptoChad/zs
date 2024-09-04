import { useEffect, useState } from "react";
import { NavigateFunction, useNavigate } from "react-router-dom";
import { API } from "../api/api"
import { Button, Flex, Text, Spinner } from "@chakra-ui/react";
import { Helpers } from "../utils/helpers";
import { MaintenaceBanner } from "../components/ui/maintenance/MaintenanceBanner";

const AuthCallback = (): JSX.Element => {
	document.body.style.backgroundImage = "url('backgrounds/login_background.jpeg')";
	document.body.style.backgroundPosition = "center";
	document.body.style.backgroundRepeat = "no-repeat";
	document.body.style.backgroundSize = "cover";

	const navigate: NavigateFunction = useNavigate();

	const [loading, setLoading] = useState(true);
	const [failed, setFailed] = useState(false);

	useEffect(() => {
		(async () => {
			try {
				const searchParams: URLSearchParams = new URLSearchParams(window.location.search);
				const code: string | null = searchParams.get("code");
				await API.auth.getToken(code);
				const payload = Helpers.auth.extractPayload()

				if (payload?.uuid) {
					setLoading(false);
					return navigate("/game");
				}

				setFailed(true);
				setLoading(false);
				return navigate("/");
			} catch (error: any) {
				console.log(error);
				setFailed(true);
				setLoading(false);
				throw error;
			}
		})();
	}, [navigate]);

	return (
		<Flex
			alignItems="center"
			justifyContent="center"
			direction="column"
			height="70vh"
		>
			{import.meta.env.VITE_MAINTENANCE_MODE === "true" && <MaintenaceBanner />}
			{loading && <Spinner size="xl" color="white" thickness="4px" />}
			{!loading && failed && (
				<>
					<Text
						fontSize="44px"
						fontWeight="800"
						lineHeight="51px"
						mb={2}
						textAlign="center"
						color="white"
					>
						Bridge login failed. Please try again...
					</Text>
					<Button mt={10} onClick={() => navigate("/")}>
						Return
					</Button>
				</>
			)}
		</Flex>

	);
};

export default AuthCallback;
